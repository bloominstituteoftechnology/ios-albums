//
//  AlbumController.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties

    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-fbe98.firebaseio.com/")!

    // MARK: - CRUD

    // CREATE
    func createAlbum(albumName: String, artist: String, coverArt: [URL] = [], genres: [String] = [], songs: [Song] = []) {
        let newAlbum = Album(name: albumName, artist: artist, identifier: UUID(), coverArt: coverArt, genres: genres, songs: songs)
        
        albums.append(newAlbum)
        
        put(album: newAlbum)
    }
    
    func createSong(title: String, duration: String) -> Song {
        return Song(title: title, duration: duration, identifier: UUID())
    }
    
    // UPDATE
    func update(album: Album, withName albumName: String, artist: String, coverArt: [URL], genres: [String], songs: [Song]) {
        guard let index = albums.firstIndex(where: { $0.identifier == album.identifier }) else { return }
        
        // Update local array
        albums[index].name = albumName
        albums[index].artist = artist
        albums[index].coverArt = coverArt
        albums[index].genres = genres
        albums[index].songs = songs
        
        // Update server API database
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
                // [{String: Album}] --> [Album]
                self.albums = Array(try JSONDecoder().decode([String: Album].self, from: data).values)
                print("Successfully decoded data from server for \(self.albums.count) albums!")
                var albumCount = 0
                for album in self.albums {
                    albumCount += 1
                    print("\t\(albumCount). \"\(album.name)\"")
                }
                DispatchQueue.main.async { completion(nil) }
            } catch {
                print("Error decoding data from the server: \(error)")
                DispatchQueue.main.async { completion(.decodingError) }
            }
        }.resume()
    }
    
    // PUT data to server
    private func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL
            .appendingPathComponent(album.identifier.uuidString)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
            print("Successfully encoded album data for \"\(album.name)\"!")
        } catch {
            print("Error encoding data for \"\(album.name)\": \(error)")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            guard error == nil else {
                print("Error PUTting data to server for \"\(album.name)\": \(error!)")
                DispatchQueue.main.async { completion(.otherError) }
                return
            }
            
            print("Successfully PUT album data for \"\(album.name)\" to server!")
            DispatchQueue.main.async { completion(nil) }
            
        }.resume()
    }
    
    // DELETE data from server
    // Not part of MVP
    
}

// MARK: - Helper Enums

extension AlbumController {
    typealias CompletionHandler = (NetworkError?) -> Void
    
    enum HTTPMethod: String {
        case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noAuth, badAuth, otherError, badData, decodingError, encodingError
    }
}

// MARK: - Codable Testing Functions
/*
extension AlbumController {
    @discardableResult func testDecodingExampleAlbum() -> Album? {
        defer { print("DONE: AlbumController.testDecodingExampleAlbum()\n") }
        print("AlbumController.testDecodingExampleAlbum()")
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("Error: Could not locate JSON file in App bundle.")
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: urlPath)
            let decodedData = try JSONDecoder().decode(Album.self, from: jsonData)
            print("Successfully decoded data from JSON file!")
            //print(String(data: jsonData, encoding: .utf8)!)
            return decodedData
        } catch {
            print("Error decoding data from JSON file: \(error).")
            return nil
        }
    }
    
    func testEncodingExampleAlbum() {
        defer { print("DONE: AlbumController.testEncodingExampleAlbum()\n") }
        print("AlbumController.testEncodingExampleAlbum()")
        if let decodedData = testDecodingExampleAlbum() {
            print("AlbumController.testEncodingExampleAlbum()")
            do {
                let _ = try JSONEncoder().encode(decodedData)
                print("Successfully encoded data back into JSON!")
                //print(String(data: encodedData, encoding: .utf8)!)
            } catch {
                print("Error encoding album back into JSON: \(error).")
            }
        }
    }
}
*/
