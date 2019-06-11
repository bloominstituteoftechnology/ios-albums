//
//  AlbumController.swift
//  Albums
//
//  Created by Hayden Hastings on 6/10/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

class AlbunController {
    
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-6c899.firebaseio.com/")!
    typealias CompletionHandler = (Error?) -> Void
    
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "Get"
        
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
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) -> Album {
        let newAlbum = Album(artist: artist)
    }
    
    func createSong(name: String, id: String, duration: String) {
        
    }
    
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
