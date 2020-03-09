//
//  AlbumController.swift
//  Albums
//
//  Created by Ufuk Türközü on 09.03.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-ab3b7.firebaseio.com/")!
    
    func getAlbums(completion: @escaping ((Error?) -> Void) = { _ in }) {
        URLSession.shared.dataTask(with: baseURL.appendingPathExtension("json")) { (data, _, error) in
            
            if let error = error {
                NSLog("\(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            
            do {
                self.albums = Array(try JSONDecoder().decode([String: Album].self, from: data).values)
                completion(nil)
            } catch {
                NSLog("\(error)")
                completion(error)
            }
            
        }.resume()
    }
    
    func createAlbum(with name: String, artist: String, coverArtURLs: [URL], genres: [String], songs: [Song]) {
        
        let album = Album
        
        albums.append(album)
        
        send(album: album)
    }
    
    func createSong(with title: String, duration: String) -> Song {
        return Song(
    }
    
    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        let data = try? Data(contentsOf: urlPath)
        
        URLSession.shared.dataTask(with: urlPath) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching songs from File: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from File")
                return
            }
            
            do {
                let songs = Array(try JSONDecoder().decode([Album].self, from: data).values)
            } catch {
                NSLog("Error decoding songs from Firebase: \(error)")
            }
        }.resume()
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        URLSession.shared.dataTask(with: urlPath) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching songs from File: \(error)")
                return
            }
            
            do {
                let songs = Array(try JSONEncoder().encode([String : Album].self, from: data).values)
            } catch {
                NSLog("Error decoding songs from Firebase: \(error)")
            }
        }.resume()
    }
}
