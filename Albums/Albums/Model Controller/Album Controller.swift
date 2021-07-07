//
//  Album Controller.swift
//  Albums
//
//  Created by Jonalynn Masters on 10/28/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
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
    var songs: [Songs] = []
    let baseURL = URL(string: "https://albums-9d62f.firebaseio.com/")!
    typealias CompletionHandler = (Error?) -> Void

// MARK: Fetching Albums
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching album: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned by data task")
                completion(NSError())
                return
            }
            DispatchQueue.main.async {
                do {
                    let newAlbum = try JSONDecoder().decode([String: Album].self, from: data).map() { $0.value }
                    self.albums = newAlbum
                } catch {
                    NSLog("Error decoding album: \(error)")
                }
            }
        }.resume()
    }
    
//MARK: Put Function
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTing album: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
// MARK: Create Album
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Songs]) -> Album {
        let newAlbum = Album(name: name, artist: artist, coverArt: coverArt, id: id, genres: genres, songs: songs)
        albums.append(newAlbum)
        put(album: newAlbum)
        return newAlbum
    }
    
// MARK: Test Decoding Example Album
    func testDecodingExampleAlbum() {
        
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let json = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: json)
            print("\(album)")
        } catch {
            NSLog("Error loading test data: \(error)")
        }
    }
    // MARK: Test Encoding Example Album
    func testEncodingExampleAlbum() {
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let json = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: json)
            print("\(album)")
        } catch {
            NSLog("Error loading test data: \(error)")
        }
    }
}
