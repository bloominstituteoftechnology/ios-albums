//
//  AlbumController.swift
//  Albums
//
//  Created by Gi Pyo Kim on 10/28/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case representationNil
    case encodingError
    case decodingError
    case putError
    case deleteError
    case fetchError
    case noData
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class AlbumController {
    
    var albums: [Album] = []
    let baseURL: URL = URL(string: "https://ios-movie-watch-list.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (NetworkingError?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(.fetchError)
                return
            }
            
            guard let data = data else {
                NSLog("No data retrun from album fetch data task")
                completion(.noData)
                return
            }
            
            do {
                let albumDictionary = try JSONDecoder().decode([String: Album].self, from: data)
                self.albums = albumDictionary.compactMap{ $0.value }
                
            } catch {
                NSLog("Error decoding albums")
                completion(.decodingError)
            }
            completion(nil)
        }.resume()
    }
    
    func put(album: Album) {
        let requestURL = baseURL.appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Erro encoding album: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Erro PUTing album: \(error)")
                return
            }
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        put(album: newAlbum)
        albums.append(newAlbum)
    }
    
    func createSong(duration: String, id: UUID, name: String) -> Song {
        return Song(duration: duration, id: id, name: name)
    }
    
    func update(album: inout Album, artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.id = id
        album.name = name
        album.songs = songs
        put(album: album)
    }
    
    func testDecodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
        } catch {
            NSLog("Error decoding album: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        var album: Album!
        do {
            let data = try Data(contentsOf: url)
            album = try JSONDecoder().decode(Album.self, from: data)
        } catch {
            NSLog("Error decoding album: \(error)")
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let weezerData = try encoder.encode(album)
            let dataAsString = String(data: weezerData, encoding: .utf8)!
            print(dataAsString)
        } catch {
            NSLog("Error encoding album: \(error)")
        }
    }
    
    
    
}
