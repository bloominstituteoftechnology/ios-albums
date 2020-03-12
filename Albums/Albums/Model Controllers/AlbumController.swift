//
//  AlbumController.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Custom Types

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum NetworkError: Error {
        case noAuth
        case badAuth
        case otherError
        case badData
        case decodingError
        case encodingError
    }
    
    typealias CompletionHandler = (NetworkError?) -> Void
    
    // MARK: - Properties

    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-fbe98.firebaseio.com/")!
    
    // MARK: - Initializers

    init() {
        getAlbums()
    }

    // MARK: - CRUD

    // CREATE
    func createAlbum(albumName: String, artist: String, songs: [Song], coverArt: [URL], genres: [String], id: String) {
        let newAlbum = Album(artist: artist, coverArtURLs: coverArt, genres: genres, id: id, name: albumName, songs: songs)
        albums.append(newAlbum)
        put(album: newAlbum)
    }
    
    func createSong(title: String, duration: String, id: String) -> Song {
        return Song(duration: duration, id: id, title: title)
    }
    
    // UPDATE
    func update(album: Album, albumName: String, artist: String, songs: [Song], coverArt: [URL], genres: [String], id: String) {
        guard let index = albums.firstIndex(where: { $0.id == id }) else { return }
        
        albums[index].name = albumName
        albums[index].artist = artist
        albums[index].songs = songs
        albums[index].coverArtURLs = coverArt
        albums[index].genres = genres
        albums[index].id = id
        
        put(album: albums[index])
    }
    
    
    // DELETE
    // Not part of MVP
    
    // MARK: - Server API Sync

    // GET data from server
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            guard error == nil else {
                print("Error fetching data from server: \(error!)")
                DispatchQueue.main.async { completion(.otherError) }
                return
            }
            
            guard let data = data else {
                print("No data returned by data task.")
                DispatchQueue.main.async { completion(.badData) }
                return
            }
            
            do {
                //self.albums = Array(try JSONDecoder().decode([String: Album].self, from: data).values)
                self.albums = try JSONDecoder().decode([Album].self, from: data)
                DispatchQueue.main.async { completion(nil) }
            } catch {
                print("Error decoding data from the server: \(error)")
                DispatchQueue.main.async { completion(.decodingError) }
            }
            
        }.resume()
    }
    
    // PUT data to server
    private func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(albums)
        } catch {
            print("Error encoding data: \(error)")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error PUTting data to server: \(error!)")
                DispatchQueue.main.async { completion(.otherError) }
                return
            }
            
            DispatchQueue.main.async { completion(nil) }
            
        }.resume()
    }
    
    // DELETE data from server
    // Not part of MVP
    
}

// MARK: - Codable Testing Functions

extension AlbumController {
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("Error: Could not locate JSON file in App bundle.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: urlPath)
            let _ = try JSONDecoder().decode(Album.self, from: jsonData)
        } catch {
            print("Error decoding data from JSON file: \(error).")
            return
        }
        
        print("Successfully decoded data from JSON file!")
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("Error: Could not locate JSON file in App bundle.")
            return
        }
        
        let album: Album
        
        do {
            let jsonData = try Data(contentsOf: urlPath)
            album = try JSONDecoder().decode(Album.self, from: jsonData)
        } catch {
            print("Error decoding data from JSON file: \(error).")
            return
        }
                
        do {
            let _ = try JSONEncoder().encode(album)
        } catch {
            print("Error encoding album back into JSON: \(error).")
            return
        }
        
        print("Successfully encoded data back into JSON!")
        
    }
}
