//
//  AlbumController.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    private var testJSONurl: URL? {
        return Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
    }
    private let baseURL = URL(string: "https://mcelhinney-albums.firebaseio.com/")!
    
    var albums: [Album] = []
    
    // MARK: - CRUD Methods
    /// Creates an album with the given properties, adds it to the albums array and PUTs it to the server
    func createAlbum(name: String, artist: String, genres: [String], coverArtURLs: [URL], songs: [Song]? = nil) {
        let album = Album(name: name, artist: artist, genres: genres, coverArtURLs: coverArtURLs)
        
        if let songs = songs {
            for song in songs {
                album.songs.append(song)
            }
        }
        
        albums.append(album)
        put(album: album)
    }
    
    /// Creates a song with the given properties and returns it
    func createSong(title: String, duration: String, id: String = UUID().uuidString) -> Song {
        let song = Song(title: title, duration: duration, id: id)
        return song
    }
    
    /// Updates an album with the given properties and PUTs it to the server
    func update(album: Album, with name: String, artist: String, genres: [String], coverArtURLs: [URL], songs: [Song]) {
        album.name = name
        album.artist = artist
        album.genres = genres
        album.coverArtURLs = coverArtURLs
        album.songs = songs
        
        put(album: album)
    }
    
    // MARK: - Netorking
    /// Fetches all the albums from the server and stores it in the albums array
    func fetchAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error GETting albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError())
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([String: Album].self, from: data).map() { $0.value }
                completion(nil)
                return
            } catch {
                NSLog("Error decoding albums \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    /// PUTs an album to the server
    private func put(album: Album) {
        let requestURL = baseURL.appendingPathComponent("\(album.id)").appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encdoing album: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error PUTting album to server: \(error)")
            }
        }.resume()
    }
    
    
    
    // MARK: - Testing Methods
    /// Tests decoding an album from the example JSON
    private func testDecodingExampleAlbum() {
        guard let url = testJSONurl else {
            NSLog("JSON file doesn't exist. Check your spelling.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: jsonData)
            print("Success! Decoded an album: \(decodedAlbum)")
            put(album: decodedAlbum)
        } catch {
            NSLog("Error decoding album: \(error)")
            return
        }
    }
    
    /// Test encoding the example JSON
    private func testEncodingExampleAlbum() {
        guard let url = testJSONurl else {
            NSLog("JSON file doesn't exist. Check your spelling.")
            return
        }
        
        var album: Album?
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: jsonData)
            print("Success! Decoded an album: \(decodedAlbum)")
            album = decodedAlbum
        } catch {
            NSLog("Error decoding album: \(error)")
            return
        }
        
        do {
            let encodedAlbum = try JSONEncoder().encode(album)
            print("Success! Encoded an album{ \(encodedAlbum)")
        } catch {
            NSLog("Error encoding album: \(error)")
        }
    }
    
    
}
