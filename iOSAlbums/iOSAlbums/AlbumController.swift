//
//  AlbumController.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://iosalbums-angel.firebaseio.com/")!
    
    // MARK: - Functions
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(newAlbum)
        put(newAlbum)
        
    }
    
    func createSong(name: String, duration: String, id: UUID) -> Song {
        let newSong = Song(name: name, duration: duration, id: id)
        return newSong
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        var albumToUpdate = album
        albumToUpdate.artist = artist
        albumToUpdate.coverArt = coverArt
        albumToUpdate.genres = genres
        albumToUpdate.id = id
        albumToUpdate.name = name
        albumToUpdate.songs = songs
        
        put(albumToUpdate)
    }
    
    // MARK: - Networking
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        let urlPlusJSON = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: urlPlusJSON) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving albums from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No album data returned from server")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let albumsFromServer = try decoder.decode([String: Album].self, from: data)
                print("These are the albums from server: \(albumsFromServer)")
                let albumsArray = Array(albumsFromServer.values)
                for album in albumsArray {
                    self.albums.append(album)
                }
                print(self.albums.count)
                completion(nil)
            } catch {
                NSLog("Error decoding albums from server: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func put(_ album: Album) {
        let id = album.id.uuidString
        let url = baseURL.appendingPathComponent(id)
        let urlPlusJSON = url.appendingPathExtension("json")
        
        var request = URLRequest(url: urlPlusJSON)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            let albumJSON = try encoder.encode(album)
            request.httpBody = albumJSON
        } catch {
            NSLog("Error encoding album: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error putting album to server: \(error)")
                return
            }
        }.resume()
    }
    
    func testDecodingExampleAlbum() {
        
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        do {
            let album = try decoder.decode(Album.self, from: data)
            print("\(album)")
        } catch {
            NSLog("Error decoding album data: \(error)")
        }
        
        
    }
    
    func testEncodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        do {
            let album = try decoder.decode(Album.self, from: data)
            do {
                let encoder = JSONEncoder()
                let albumData = try encoder.encode(album)
                let albumDataDecoded = try decoder.decode(Album.self, from: albumData)
                print("This is the album re-encoded: \(albumData)")
                print("\(albumDataDecoded)")
            } catch {
                NSLog("Error encoding album data: \(error)")
            }
            
            
        } catch {
            NSLog("Error decoding album data: \(error)")
        }
        
        
    }
}
