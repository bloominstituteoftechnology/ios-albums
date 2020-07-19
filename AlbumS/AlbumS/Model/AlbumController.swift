//
//  AlbumController.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case put = "PUT"
  case post = "POST"
  case delete = "DELETE"
}

class AlbumController {
  
  var albums: [Album] = []
  private let baseURL = URL(string: "https://album-840eb.firebaseio.com/")!
  
  func getAlbums(completion: @escaping (Error?) -> Void) {
    
    let requestURL = baseURL.appendingPathExtension("json")
    let request = URLRequest(url: requestURL)
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
        completion(error)
        return
      }
      
      guard let data = data else {
        NSLog("No data from Firebase")
        completion(NSError(domain: "no data", code: 1, userInfo: nil))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(String(describing: response))")
          return
      }
  
      do {
        
        let decodedAlbums = try JSONDecoder().decode([String:Album].self, from: data)
        self.albums =  Array(decodedAlbums.values)
        completion(nil) // No completion, the completion's closure will not work
        return
        
      } catch let err as NSError {
        print(err.localizedDescription)
        completion(err)
        return 
      }
      
    }.resume()
  }
  
  func put(album:Album, completion: @escaping (Error?) -> Void  = { _ in } ) {
    //
    let requestURL = baseURL.appendingPathComponent(album.id)
      .appendingPathExtension("json")
    
    var request = URLRequest(url: requestURL)
    request.httpMethod = HTTPMethod.put.rawValue
    
    do {
      let albumData = try JSONEncoder().encode(album)
      request.httpBody = albumData
      
    } catch let err as NSError {
      NSLog("Error encoding album")
      completion(err)
      return
    }
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        NSLog("Network error Putting data to server: \(error)")
        completion(error)
        return
      }
      completion(nil)
    }.resume()
    
  }
  func createAlbum(artist:String,coverArt:[URL],genres:[String],id:String,name:String,songs:[Song]) {
    //
    let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
    albums.append(newAlbum)
    put(album: newAlbum)
  }
  
  
  func createSong(duration: String, id: String, name: String) -> Song {
    //
    return Song(duration: duration, id: id, name: name)
  }
  
  
  func update(album: Album, artist:String,coverArt:[URL],genres:[String],id:String,name:String,songs:[Song] ) {
    
    guard let index = albums.firstIndex(of: album) else { return }
    var scratchAlbum = album
    
    scratchAlbum.artist = artist
    scratchAlbum.coverArt = coverArt
    scratchAlbum.genres = genres
    scratchAlbum.id = id
    scratchAlbum.name = name
    scratchAlbum.songs =  songs
    
    albums[index] = scratchAlbum
    put(album: scratchAlbum)
  }
}

extension AlbumController {
  func testDecodingExampleAlbum() {
    let urlPath =  Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    do {
      let jsonData = try Data(contentsOf: urlPath)
      
      let data = try  JSONDecoder().decode(Album.self, from: jsonData)
      print(data)
    } catch let err as NSError {
      print(err)
    }
    
  }
  
  func testEncodingExampleAlbum() {
    let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    do {
      let data = try! Data(contentsOf: urlPath)
      let decoder = JSONDecoder()
      let album = try decoder.decode(Album.self, from: data)
      print(album)
      
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      
      let json = try encoder.encode(album)
      let dataAsString = String(data: json, encoding: .utf8)!
      print(dataAsString)
      
      //      createAlbum(artist: album.artist, coverArt: album.coverArt, genres:album.genres, id: UUID().uuidString, name: album.name, songs: album.songs)
      
    } catch {
      print(error)
    }
    
  }
}
