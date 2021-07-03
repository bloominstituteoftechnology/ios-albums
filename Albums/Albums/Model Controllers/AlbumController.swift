//
//  AlbumController.swift
//  Albums
//
//  Created by Michael Stoffer on 7/24/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

let baseURL: URL = URL(string: "https://album-project-4a732.firebaseio.com/")!

class AlbumController {
    typealias CompletionHandler = (Error?) -> Void
    
    var albums: [Album] = []
    
    func createAlbum(withName name: String, withArtist artist: String, withCoverArt coverArt: [String], withGenres genres: [String], withSongs songs: [Song]) {
        let album = Album(name: name, artist: artist, coverArt: coverArt, genres: genres, songs: songs)
        self.put(album: album)
    }
    
    func createSong(withName name: String, withDuration duration: String) -> Song {
        let song = Song(name: name, duration: duration)
        return song
    }
    
    func update(withAlbum album: Album, withName name: String, withArtist artist: String, withCoverArt coverArt: [String], withGenres genres: [String], withSongs songs: [Song]) {
        guard let i = self.albums.firstIndex(of: album) else { return }
        self.albums[i].name = name
        self.albums[i].artist = artist
        self.albums[i].coverArt = coverArt
        self.albums[i].genres = genres
        self.albums[i].songs = songs
        
        self.put(album: self.albums[i])
    }
    
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let url = baseURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else { NSLog("No data returned from data task"); completion(NSError()); return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decodedDictionary = try jsonDecoder.decode([String: Album].self, from: data)
                let albums = Array(decodedDictionary.values)
                self.albums = albums
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object of type [Album]: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let uuid = album.id
        
        let requestURL = baseURL.appendingPathComponent(uuid).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"

        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album \(album): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTing album to server: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    static func testDecodingExampleAlbum() {
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("\(album)")
        } catch {
            NSLog("Unable to decode test data: \(error)")
        }
    }
    
    static func testEncodingExampleAlbum() {
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("\(album)")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let encodedAlbum = try encoder.encode(album)
            let albumString = String(data: encodedAlbum, encoding: .utf8)
            print(albumString!)
        } catch {
            NSLog("Unable to encode test data: \(error)")
        }
    }
}
