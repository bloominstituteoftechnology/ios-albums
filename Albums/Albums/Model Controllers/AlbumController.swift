//
//  AlbumController.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HeaderNames: String {
    case auth = "Authorization"
    case contentType = "Content-Type"
}

class AlbumController {
    
    //MARK: Properties
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://albums-f26a2.firebaseio.com/")!
    
    //MARK: Methods
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: UUID = UUID(), name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(duration: String, id: UUID = UUID(), name: String) -> Song {
        let song = Song(duration: duration, id: id, name: name)
        return song
    }
    
    func update( from album: inout Album, artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.name = name
        album.songs = songs
        put(album: album)
    }
    
    //MARK: Networking
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL.appendingPathExtension("json")) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            do {
                let albums = try JSONDecoder().decode([String: Album].self, from: data)
                self.albums = albums.map({ $0.value })
                completion(nil)
            } catch {
                NSLog("Error decoding albums: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func put(album: Album) {
        let requestURL = baseURL.appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
        
        do {
            let albumJSON = try JSONEncoder().encode(album)
            request.httpBody = albumJSON
        } catch {
            NSLog("Error encoding album data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
            }
        }.resume()
    }
    
    //MARK: Tests
    
    func testDecodingExampleAlbum() {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!)
        
        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            NSLog("\(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!)
        
        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let albumData = try encoder.encode(album)
            
            let dataAsString = String(data: albumData, encoding: .utf8)!
            print(dataAsString)
        } catch {
            NSLog("\(error)")
        }
    }
    
}
