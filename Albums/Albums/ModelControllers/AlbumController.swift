//
//  AlbumController.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation


class AlbumController {
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-e47d1.firebaseio.com/")!
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        do {
            let data = try! Data(contentsOf: urlPath)
            let decoder = JSONDecoder()
            let json = try decoder.decode(Album.self, from: data)
            print(json)
        } catch {
            print(error)
        }
    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        do {
            let data = try! Data(contentsOf: urlPath)
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            print(album)
            
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//
//            let json = try encoder.encode(album)
//            let dataAsString = String(data: json, encoding: .utf8)!
//            print(dataAsString)
            
//            createAlbum(name: album.name, genres: album.genres, artist: album.artist, coverArtURLs: album.coverArtURLs, songs: album.songs)
            
        } catch {
            print(error)
        }
        
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Network Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from api")
                completion(NSError(domain: "no data", code: 1, userInfo: nil))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let albums = try decoder.decode([String: Album].self, from: data)
                self.albums = Array(albums.values)
                completion(nil)
                return
            } catch {
                NSLog("Error Decoding albums: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void) {
        let id = album.id.uuidString
        let albumURL = baseURL.appendingPathComponent(id).appendingPathExtension("json")
        
        var request = URLRequest(url: albumURL)
        request.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        do {
            let json = try encoder.encode(album)
            request.httpBody = json
        } catch {
            NSLog("Error encoding Album: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Network Error PUTting album to API: \(error)")
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Non success response received from api, reponse code was: \(response.statusCode)")
                completion(NSError(domain: "Response Code: ", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(nil)
                return
            }
            
            
        }.resume()
        
    }
    
    func createAlbum(name: String, genres: [String], artist: String, coverArtURLs: [URL], songs: [Song]) {
        let id = UUID()
        let album = Album(id: id, name: name, genres: genres, artist: artist, coverArtURLs: coverArtURLs, songs: songs)
        self.albums.append(album)
        put(album: album) { (error) in
            if let error = error {
                NSLog("Error was: \(error)")
                return
            }
        }
  
    }
    
    func update(album: Album, name: String, genres: [String], artist: String, coverArtURLs: [URL], songs: [Song]) {
        let newAlbum = Album(id: album.id, name: name, genres: genres, artist: artist, coverArtURLs: coverArtURLs, songs: songs)
        if let index = albums.firstIndex(of: album) {
            albums.replaceSubrange(index...1, with: [newAlbum])
            
        }
        put(album: newAlbum) { (error) in
            if let error = error {
                NSLog("Error was: \(error)")
                return
            }
        }
        
    }
    
    func createSong(duration: String, title: String) -> Song {
        let id = UUID()
        let song = Song(id: id, duration: duration, title: title)
        return song
    }
    
}
