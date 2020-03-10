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
                completion(NSError())
                return
            }
            
            
            do {
                let jsonDecoder = JSONDecoder()
               let decodedAlbums = try jsonDecoder.decode([String:Album].self, from: data)
                decodedAlbums.values.forEach { (album) in
                    self.albums.append(album)
                }
            } catch let err as NSError {
                print(err)
                completion(err)
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
   
    
    func testDecodingExampleAlbum() {
        let urlPath =  Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        do {
               let jsonData = try Data(contentsOf: urlPath)
            let jsonDecoder = JSONDecoder()
              let data = try  jsonDecoder.decode(Album.self, from: jsonData)
            print(data)
        } catch let err as NSError {
            print(err)
        }

    }

    func testEncodingExampleAlbum() {

        let urlPath =  Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
             do {
                let jsonData = try Data(contentsOf: urlPath)
                let jsonDecoder = JSONDecoder()
                let data = try  jsonDecoder.decode(Album.self, from: jsonData)
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                let newData = try  jsonEncoder.encode(data)
                let stringData = String(data: newData, encoding: .utf8)
                print(stringData!)
                
             }
             catch let err as NSError {
                 print(err.localizedDescription)
             }

    }

    
    
    
}
