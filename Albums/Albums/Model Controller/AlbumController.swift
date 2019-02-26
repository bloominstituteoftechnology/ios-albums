//
//  AlbumController.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums = [Album]()
    static let baseURL = URL(string: "https://albums-e152e.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let url = AlbumController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error getting JSON data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not received.")
                completion(error)
                return
            }
            
            do {
                let decodedAlbums = try JSONDecoder().decode([String: Album].self, from: data)
                let albums = decodedAlbums.map { $0.value }
                self.albums = albums
                completion(nil)
            }
            catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func put(album: Album) {
        let url = AlbumController.baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        }
        catch {
            NSLog("Error encoding album: \(album) \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
            }
        }.resume()
    }
    
    func createAlbum(albumCover: [String], artist: String, albumName: String, genres: [String], id: String, songs: [Song]) {
        
        let newAlbum = Album(albumCover: albumCover, artist: artist, albumName: albumName, genres: genres, id: id, songs: songs)
        
        put(album: newAlbum)
    }
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ;
            return
        }
        
        do {
            let exampleData = try Data(contentsOf: url)
            
            _ = try JSONDecoder().decode(Album.self, from: exampleData)
            
            print("Success!")
        }
        catch {
            print("Error getting data or decoding date: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ;
            return
        }
        
        do {
            let exampleData = try Data(contentsOf: url)
            
            let album = try JSONDecoder().decode(Album.self, from: exampleData)
            
            _ = try JSONEncoder().encode(album)
            
            print("Success!")
        }
        catch {
            print("Error getting data or decoding date: \(error)")
        }
        
    }
}
