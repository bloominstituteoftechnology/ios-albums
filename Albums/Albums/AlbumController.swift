//
//  AlbumController.swift
//  Albums
//
//  Created by Enrique Gongora on 3/9/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
}

class AlbumController {
    
    // MARK: - Variables
    var albums: [Album] = []
    var baseURL = URL(string: "https://albums-c6863.firebaseio.com/")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: Functions
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            
            do {
                self.albums = Array(try JSONDecoder().decode([String: Album].self, from: data).values)
                completion(nil)
                return
            } catch {
                NSLog("Error decoding: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathComponent(album.identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            let albumData = try JSONEncoder().encode(album)
            request.httpBody = albumData
        } catch {
            NSLog("Error encoding album: \(error)")
            completion(error)
            return
        }
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], identifier: String, name: String, songs: [Song]) {
        let album = Album(name: name, artist: artist, identifier: identifier, coverArt: coverArt, genres: genres, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(duration: String, identifier: String, name: String) -> Song {
        return Song(title: duration, identifier: identifier, duration: duration)
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], identifier: String, name: String, songs: [Song]) {
        let updatedAlbum = album
        updatedAlbum.artist = artist
        updatedAlbum.coverArt = coverArt
        updatedAlbum.genres = genres
        updatedAlbum.identifier = identifier
        updatedAlbum.name = name
        updatedAlbum.songs = songs
        put(album: updatedAlbum)
    }
    
    // MARK: - Testing Methods
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        let album = try! JSONDecoder().decode(Album.self, from: data)
        print(album)
    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        let album = try! JSONEncoder().encode(data)
        print(album)
    }
    
}
