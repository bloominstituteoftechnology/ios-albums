//
//  AlbumController.swift
//  Albums
//
//  Created by Kat Milton on 8/5/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

class AlbumController {
    var albums: [Album] = []
    
    // MARK: - Networking Code
    let baseURL = URL(string: "https://albums-949b2.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error GETting albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned.")
                completion(NSError())
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([String : Album].self, from: data).map() { $0.value }
                completion(nil)
                return
            } catch {
                NSLog("Error decoding albums \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void = { _ in }) {
        do {
            let requestURL = baseURL.appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = "PUT"
            let body = try JSONEncoder().encode(album)
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { (_, _, error) in
                if let error = error {
                    NSLog("Error saving album to server: \(error)")
                }
                completion(error)
                }.resume()
            
        } catch {
            NSLog("Error encoding album: \(error)")
            completion(error)
            return
        }
    }
    
    // MARK: - App functions
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: UUID = UUID(), name: String, songs: [Song]) {
       
       let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(title: String, duration: String, id: UUID = UUID()) -> Song {
        let song = Song(id: id, duration: duration, name: title)
        return song
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        
        var updatedAlbum = album
        updatedAlbum.artist = artist
        updatedAlbum.coverArt = coverArt
        updatedAlbum.genres = genres
        updatedAlbum.id = id
        updatedAlbum.name = name
        updatedAlbum.songs = songs
        
        put(album: updatedAlbum)
    }
    
    
    
    
}

extension AlbumController {
    func testDecodingExampleAlbum() {
        guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let testAlbum = try decoder.decode(Album.self, from: data)
            albums.append(testAlbum)
            print(albums)
        } catch {
            NSLog("Error decoding: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: filePath)
            let decodedData = try JSONDecoder().decode(Album.self, from: data)
            let encodedData = try JSONEncoder().encode(decodedData)
            let albumString = String(data: encodedData, encoding: .utf8)!
            print(albumString)
        } catch {
            NSLog("Error encoding: \(error)")
        }
        
    }
}
