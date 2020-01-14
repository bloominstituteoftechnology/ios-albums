//
//  AlbumController.swift
//  Albums
//
//  Created by Chad Rutherford on 1/13/20.
//  Copyright © 2020 chadarutherford.com. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class AlbumController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var albums = [Album]()
    let baseURL = URL(string: "https://albums-ab6c2.firebaseio.com/")
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"), let data = try? Data(contentsOf: url) else { return }
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch let decodeError {
            print(decodeError)
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"), let data = try? Data(contentsOf: url) else { return }
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        do {
            let album = try decoder.decode(Album.self, from: data)
            let albumData = try encoder.encode(album)
            print(String(data: albumData, encoding: .utf8)!)
        } catch let decodeError {
            print(decodeError)
        }
    }
    
    func getAlbums(completion: @escaping (Error?) -> ()) {
        guard let url = baseURL?.appendingPathExtension("json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(NSError(domain: "AlbumError", code: response.statusCode, userInfo: nil))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(NSError(domain: "AlbumError", code: 0, userInfo: nil))
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let albumsData = try decoder.decode([String: Album].self, from: data)
                self.albums = Array(albumsData.values)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch let decodeError {
                DispatchQueue.main.async {
                    completion(decodeError)
                }
                return
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping (Error?) -> () = { error in }) {
        guard let requestURL = baseURL?.appendingPathComponent(album.id).appendingPathExtension("json") else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let albumData = try encoder.encode(album)
            request.httpBody = albumData
        } catch let encodeError {
            completion(encodeError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(NSError(domain: "PutError", code: response.statusCode, userInfo: nil))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func create(id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let newAlbum = Album(id: id, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: songs)
        albums.append(newAlbum)
        put(album: newAlbum)
    }
    
    func createSong(id: String, name: String, duration: String) -> Song {
        return Song(id: id, name: name, duration: duration)
    }
    
    func update(_ album: Album, id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        guard let index = albums.firstIndex(of: album) else { return }
        var album = album
        album.id = id
        album.name = name
        album.artist = artist
        album.genres = genres
        album.coverArt = coverArt
        album.songs = songs
        
        albums[index] = album
        put(album: album)
    }
}
