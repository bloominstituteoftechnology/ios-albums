//
//  AlbumController.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import Foundation

class AlbumController {
    
    
    // MARK: - Testing Methods
    
//    func testDecodingExampleAlbum(){
//
//        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
//        let data = try! Data(contentsOf: url)
//        let decoder = JSONDecoder()
//        do {
//            let exampleAlbum = try decoder.decode(Album.self, from: data)
//
//        } catch {
//            NSLog("Error decoding JSON data: \(error)")
//            return
//        }
//
//    }
    
//    func testEncodingExampleAlbum() {
//        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
//        let data = try! Data(contentsOf: url)
//        let decoder = JSONDecoder()
//        var exampleAlbum: Album
//        do {
//            exampleAlbum = try decoder.decode(Album.self, from: data)
//
//        } catch {
//            NSLog("Error decoding JSON data: \(error)")
//            return
//        }
//
//        let album = exampleAlbum
//
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = [.prettyPrinted]
//        let albumData = try! encoder.encode(album)
//
//        let decoder2 = JSONDecoder()
//        let exampleAlbum2: Album =
//        do {
//            exampleAlbum2 = try decoder2.decode(Album.self, from: albumData)
//
//        } catch {
//            NSLog("Error decoding JSON data: \(error)")
//            return
//        }
//    }
    
    // MARK: - CRUD Methods
    
    /**
     Creates an Album with given properties
     */
    func createAlbum(name: String, artist: String, genres: [String], coverArtURLs: [URL], songs: [Song]? = nil) {
        
        let album = Album(name: name, artist: artist, genres: genres, coverArtURLs: coverArtURLs)
        
        if let songs = songs {
            for song in songs {
                album.songs.append(song)
            }
        }
        
        albums.append(album)
        print("here")
        put(album: album)
        
    }
    
    /**
        Creates and returns a song
     */
    func createSong(title: String, duration: String, id: String = UUID().uuidString) -> Song {
        let song = Song(title: title, duration: duration, id: id)
        return song
        
    }
    
    /**
     Updates an Album with given properties
     */
    func updateAlbum(album: Album, name: String, artist: String, coverArtURLs: [URL], genres: [String], songs: [Song]){
        
        album.name = name
        album.artist = artist
        album.coverArtURLs = coverArtURLs
        album.genres = genres
        album.songs = songs
        
        put(album: album)
        
    }
    
    // MARK: - Networking
    func getAlbums(completion: @escaping CompletionHandler = { _ in }){
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL){(data, _, error) in
            
            if let error = error {
                NSLog("Error GETting albums from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError())
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([String: Album].self, from: data).map() {$0.value}
                completion(nil)
                return
            } catch {
                NSLog("Error decoding albums: \(error)")
                completion(error)
                return
            }
            
        }.resume()
        
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }){
        
        let requestURL = baseURL.appendingPathComponent("\(album.id)").appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error putting album: \(error)")
        }
        
        URLSession.shared.dataTask(with: requestURL){(_, _, error) in
            
            if let error = error {
                NSLog("Error PUTting albums to the server: \(error)")
                completion(error)
                return
            }
            print(self.albums)
            
        }.resume()
        
    }
    
    
    private var testJSONurl: URL? {
        return Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
    }
    
    var albums: [Album] = []
    var baseURL: URL = URL(string: "https://categories-33813.firebaseio.com/")!
    
}
