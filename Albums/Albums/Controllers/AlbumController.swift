//
//  AlbumController.swift
//  Albums
//
//  Created by Vici Shaweddy on 10/30/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class AlbumController {
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-41662.firebaseio.com/")!
    
    func getAlbums(completion: @escaping () -> Void = { }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                completion()
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let album = try decoder.decode([String: Album].self, from: data)
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
    func put(album: Album, completion: @escaping () -> Void = {}) {
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album: \(error.localizedDescription)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error PUTting album: \(error.localizedDescription)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: [String], genres: [String], id: String, name: String, songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        self.albums.append(newAlbum)
        self.put(album: newAlbum)
    }
    
    func createSong(duration: String, id: String, name: String) -> Song {
        let newSong = Song(duration: duration, id: id, name: name)
        return newSong
    }
    
    func update(with album: Album, artist: String, coverArt: [String], genres: [String], id: String, name: String, songs: [Song]) {
        let updateAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: album.id, name: name, songs: songs)
        self.put(album: updateAlbum)
    }
    
    func testDecodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Album.self, from: data)
                testEncodingExampleAlbum(data: jsonData)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
    
    func testEncodingExampleAlbum(data: Album) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(data)
            if let jsonDataAsString = String(data: jsonData, encoding: .utf8) {
                print(jsonDataAsString)
            }
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
}
