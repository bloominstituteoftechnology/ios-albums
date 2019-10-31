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
        
        let baseUrl = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: baseUrl) { (data, _, error) in
            if let _ = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            do {
                let albums = Array(try JSONDecoder().decode([String: Album].self, from: data).values)
                self.albums = albums
            } catch {
                print("Error decoding album: \(error)")
                completion(error)
                return
            }
        }.resume()
    }

    func put(album: Album) {
        let id = album.id
        
        let requestURL = baseURL.appendingPathComponent(id.uuidString).appendingPathExtension("json")
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
    
    func createAlbum(with artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, name: name, songs: songs)
        albums.append(album)
        put(album: album)
        
    }
    
    func createSong(with duration: String, id: UUID = UUID(), name: String) -> Song {
        
        let song = Song(duration: duration, id: id, name: name)
        return song
    }
    
    func update(album: Album, artist: String, genres: [String], id: UUID = UUID(), name: String, songs: [Song]) {
        
        var album = album
        
        album.artist = artist
        album.genres = genres
        album.id = id
        album.name = name
        album.songs = songs
        
        put(album: album)
    }
    

//    func testDecodingExampleAlbum() {
//        
//        let decoder = JSONDecoder()
//        
//        if let pathString = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {
//
//            do {
//                let fileURL = URL(fileURLWithPath: pathString)
//                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
//                let album = try decoder.decode(Album.self, from: data)
//                self.albums.append(album)
//                
//            } catch {
//                print("Error Decoding Album: \(error)")
//            }
//            
//        }
//    }
//    
//    func testEncodingExampleAlbum() {
//        
//        let encoder = JSONEncoder()
//        let decoder = JSONDecoder()
//        
//        if let pathString = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {
//
//            do {
//                let fileURL = URL(fileURLWithPath: pathString)
//                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
//                let album = try decoder.decode(Album.self, from: data)
//                let album1 = try encoder.encode(album)
//                print("\(album1)")
//               
//            } catch {
//                print("Error Encoding Album: \(error)")
//            }
//            
//        }
//    }

}
