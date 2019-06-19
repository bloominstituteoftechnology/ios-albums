//
//  AlbumController.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-20c27.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Album: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Error returning data")
                completion(NSError())
                return
            }
            do {
                let decoder = JSONDecoder()
                let fetchedAlbums = try decoder.decode([String: Album].self, from: data).map({ $0.value})
                self.albums = fetchedAlbums
                completion(nil)
            } catch {
                NSLog("Error decoding albums")
                completion(error)
                return
            }
        }.resume()
        
    }
    
    func put(album: Album) {
        let uuid = album.id 
        let requestURL = baseURL.appendingPathComponent(uuid).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            <#code#>
//        }
    }
        
    
    
    func createAlbum(name: String, artist: String, genres: [String], coverArtURL: [String]) {
//        let newAlbum = Album(name: name, artist: artist, genres: genres, coverArtURL: coverArtURL)
//        albums.append(newAlbum)
//        put(album: newAlbum)
    }
    
    func createSong(title: String, duration: String) {
//        let newSong = Song(title: title, duration: duration)
//        return newSong
    }
    
    func update(album: Album, name: String, artist: String, genres: [String], coverArtURL: [String]) {
        album.albumName = name
        album.artist = artist
        album.genres = genres
        album.coverArt = coverArtURL
        put(album: album)
        
    }
    func testDecodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        
        do {
           let album = try decoder.decode(Album.self, from: data)
            print(album.albumName)
        } catch {
            NSLog("Error decoding album")
        }
    }
    
    
    
    
    func testEncodingExampleAlbum() {
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        
       
        let album = try! decoder.decode(Album.self, from: data)
        print(album)
        
        
        let encoder = JSONEncoder()
        let albumData = try! encoder.encode(album)
        print(albumData)
        
        
    }
    
}
