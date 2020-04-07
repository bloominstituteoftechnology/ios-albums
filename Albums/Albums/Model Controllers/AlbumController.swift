//
//  AlbumController.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    let baseURL: URL = URL(string: "https://albums-4f80c.firebaseio.com/")!
    
    func update(album: Album, id: String, name: String, artist: String, genres: [String], coverArt: [String], songs: [Song]) {
        let newAlbum = Album(id: id, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: songs)
        
        if let index = albums.firstIndex(of: album) {
            albums[index] = newAlbum
        }
    
        put(album: newAlbum) { (error) in
            if let error = error {
                NSLog("error putting album to server \(error)")
            }
        }
    }
    
    func createAlbum(id: String, name: String, artist: String, genres: [String], coverArt: [String], songs: [Song]) {
        let new = Album(id: id, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: songs)
        albums.append(new)
        put(album: new) { (error) in
            if let error = error {
                NSLog("error putting album to server \(error)")
            }
        }
    }
    
    func createSong(duration: String, id: String, name: String) -> Song {
        let newSong = Song(duration: duration, id: id, name: name)
        return newSong
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"

        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(album)
        } catch {
            NSLog("Error encoding/saving task: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                NSLog("Error PUTing task to server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned by data task")
                completion(NSError())
                return
            }
            
            do {
                let album = Array(try JSONDecoder().decode([String : Album].self, from: data).values)
                self.albums = album
                completion(nil)
            } catch {
                NSLog("Error decoding or saving data from Firebase: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    var object: Album?
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!

        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        
        object = try! decoder.decode(Album.self, from: data)
        print("\(object!) \n")
        testEncodingExampleAlbum()
    }
    
    func testEncodingExampleAlbum() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let albumData = try! encoder.encode(object)
        let albumDataAsString = String(data: albumData, encoding: .utf8)!
        print(albumDataAsString)
    }
}
