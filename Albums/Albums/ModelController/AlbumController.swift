//
//  AlbumController.swift
//  Albums
//
//  Created by Chris Gonzales on 3/9/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    var albums: [Album] = []
    
    let baseURL: URL = URL(string: "https://lambdatestdatabase.firebaseio.com/")!
    
    // MARK: - CRUD Methods
    
    func createAlbum(artist: String, coverArt: [URL], name: String,
                     genres: [String], songs: [Song]) {
        
        let newAlbum = Album(artist: artist,
                             coverArt: coverArt,
                             name: name,
                             genres: genres,
                             songs: songs)
        albums.append(newAlbum)
        putAlbums(album: newAlbum)
    }
    
    func createSong(name: String,
                    duration: String,
                    id: UUID = UUID()) -> Song {
        
        let newSong = Song(name: name,
                           duration: duration)
        
        return newSong
    }
    
    func update(album: Album,artist: String, coverArt: [URL],
                name: String, genres: [String],songs: [Song]) {
        album.artist = artist
        album.coverArt = coverArt
        album.name = name
        album.genres = genres
        album.songs = songs
        
        putAlbums(album: album)
    }
    
    // MARK: - API Methods
    
    func getAlbums(completion: @escaping ((Error?) -> Void) = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums from Firebase: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from Firebase")
                completion(error)
                return
            }
            
            do{
                let albumDictionary = try self.decoder.decode([String: Album].self,
                                                              from: data)
                
                for item in albumDictionary {
                    self.albums.append(item.value)
                }
                return
            } catch {
                NSLog("\(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func putAlbums(album: Album, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let requestURL = baseURL.appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        do{
            request.httpBody = try encoder.encode(album)
        } catch {
            NSLog("Error encoding Album: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTting album to Firebase: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum",
                                            withExtension: "json") else { return }
        
        URLSession.shared.dataTask(with: urlPath) { (data, _, error) in
            if let error = error {
                NSLog("Error decoding album: \(error)")
                return
            }
        }
        do{
            let data =  try Data(contentsOf: urlPath)
            print(data)
        } catch {
            NSLog("\(error)")
            return
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum",
                                            withExtension: "json") else { return }
        
        URLSession.shared.dataTask(with: urlPath) { (data, _, error) in
            if let error = error {
                NSLog("Error decoding album: \(error)")
                return
            }
        }
        do{
            let data =  try Data(contentsOf: urlPath)
            print(data)
        } catch {
            NSLog("\(error)")
            return
        }
    }
}
