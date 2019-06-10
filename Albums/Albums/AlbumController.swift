//
//  AlbumController.swift
//  Albums
//
//  Created by Kobe McKee on 6/10/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class AlbumController {
    
    
    var albums: [Album] = []
    
    let baseURL: URL = URL(string: "https://albums-be898.firebaseio.com/")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    
    func getAlbums(completion: @escaping CompletionHandler = {_ in}) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(error)
                return
            }
            
            if let error = error {
                NSLog("Error getting albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data retruned")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let albums = try decoder.decode([String: Album].self, from: data)
                self.albums = albums.map() { $0.value }
            } catch {
                NSLog("Error decoding albums: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
        
    }
    
    
    
    func put(album: Album, completion: @escaping CompletionHandler = {_ in}) {
        
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album: \(error)")
        }
            
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error putting album: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
    }
    
    
    
    
    func createAlbum(name: String, artist: String, id: String, genres: [String], coverArt: [String], songs: [Song]) {
        
        let album = Album(name: name, artist: artist, id: id, genres: genres, coverArt: coverArt, songs: songs)
        put(album: album)
        
    }
    
    func createSong(name: String, duration: String, id: String) -> Song {
        let song = Song(name: name, duration: duration, id: id)
        return song
    }
    
    func update(album: Album, name: String, artist: String, id: String, genres: [String], coverArt: [String], songs: [Song]) {
        var updatedAlbum = album
        updatedAlbum.name = name
        updatedAlbum.artist = artist
        updatedAlbum.id = id
        updatedAlbum.genres = genres
        updatedAlbum.coverArt = coverArt
        updatedAlbum.songs = songs
        
        put(album: updatedAlbum)
    }
    
    
    
    
    
    
//    func testDecodingExampleAlbum() {
//
//        let mainBundle = Bundle.main
//        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
//
//        do {
//            let json = try Data(contentsOf: fileURL)
//            let album = try JSONDecoder().decode(Album.self, from: json)
//            print("\(album)")
//        } catch {
//            NSLog("Error loading test data: \(error)")
//        }
//    }
//
//
//
//    func testEncodingExampleAlbum() {
//
//        let mainBundle = Bundle.main
//        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
//
//        do {
//            let json = try Data(contentsOf: fileURL)
//            let album = try JSONDecoder().decode(Album.self, from: json)
//
//            let encodedAlbum = try JSONEncoder().encode(album)
//            print("\(encodedAlbum)")
//        } catch {
//            NSLog("Error loading test data: \(error)")
//        }
//    }

    
    
}
