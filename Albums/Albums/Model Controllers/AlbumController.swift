//
//  AlbumController.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class AlbumController {
    
    static let shared = AlbumController()
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://albums-f45ed.firebaseio.com/")!
    
    func createAlbum(artist: String, coverArt: [String], genres: [String], id: UUID = UUID(), name: String, songs: [Song]) {
        let album = Album(id: id, name: name, artist: artist, coverArt: coverArt, genres: genres, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(duration: String, id: UUID = UUID(), name: String) -> Song {
        let song = Song(duration: duration, id: id, name: name)
        return song
    }
    
    func update(from album: inout Album, artist: String, coverArt: [String], genres: [String], name: String, songs: [Song]) {
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.name = name
        album.songs = songs
        put(album: album)
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL.appendingPathExtension("json")) { (data, _, error) in
            if let error = error {
                print("Error fetching album data: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error getting data: \(error)")
                completion(error)
                return
            }
            
            do {
                let albums = try JSONDecoder().decode([String: Album].self, from: data)
                self.albums = albums.map({ $0.value })
                completion(nil)
            } catch {
                print("Error decoding albums: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func put(album: Album) {
        let requestURL = baseURL.appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let albumJSON = try JSONEncoder().encode(album)
            request.httpBody = albumJSON
        } catch {
            print("Error encoding album data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error PUTing albums: \(error)")
            }
        }.resume()
    }
    
    func testDecodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        do {
            let decoder = JSONDecoder()
            let testAlbum = try decoder.decode(Album.self, from: data)
            print(testAlbum)
        } catch {
            print("Error decoding")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        do {
            let decoder = JSONDecoder()
            let testAlbum = try! decoder.decode(Album.self, from: data)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let album = try encoder.encode(testAlbum)
            
            let stringData = String(data: album, encoding: .utf8)!
            print(stringData)
        } catch {
            print("Error encoding")
        }
        
    }
    
}
