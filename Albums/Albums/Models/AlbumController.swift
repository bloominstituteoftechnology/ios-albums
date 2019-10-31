//
//  AlbumController.swift
//  Albums
//
//  Created by Bobby Keffury on 10/30/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    private let baseURL = URL(string: "https://albums-f4f46.firebaseio.com/")!
    
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let _ = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let dictionaryOfAlbums = try decoder.decode([String: Album].self, from: data)
                self.albums = Array(dictionaryOfAlbums.values)
            } catch {
                print("Error decoding album: \(error)")
                completion(error)
                return
            }
        }
    }

    func put(album: Album) {
        let id = album.id
        
        let requestURL = baseURL.appendingPathComponent(id)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            print("Error encoding album: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            
            if let error = error {
                print("Error PUTting album to server: \(error)")
                return
            }
   
        }.resume()
    }
    
    func createAlbum(with artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        
        let album = Album(
        albums.append(album)
        put(album: album)
        
    }
    
    func createSong(with duration: String, id: String, name: String) -> Song{
        
        let song = Song(duration: duration, id: id, name: name)
        
        return song
    }
    
    func update(album: Album, artist: String, genres: [String], id: String, name: String, songs: [Song]) {
        
        var album = album
        
        album.artist = artist
        album.genres = genres
        album.id = id
        album.name = name
        album.songs = songs
        
        put(album: album)
    }
    
    
    func testDecodingExampleAlbum() {
        
        let decoder = JSONDecoder()
        
        if let pathString = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {

            do {
                let fileURL = URL(fileURLWithPath: pathString)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let album = try decoder.decode(Album.self, from: data)
                self.albums.append(album)
                
            } catch {
                print("Error Decoding Album: \(error)")
            }
            
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let encoder = JSONEncoder()
        
        if let pathString = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {

            do {
                let fileURL = URL(fileURLWithPath: pathString)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
//                let album = try encoder.encode(Album.self)
               
            } catch {
                print("Error Encoding Album: \(error)")
            }
            
        }
    }

}
