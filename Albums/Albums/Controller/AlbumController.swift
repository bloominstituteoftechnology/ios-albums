//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    var albums: [Album] = []
    let baseURL: URL = URL(string: "https://albums-39b0f.firebaseio.com/")!
    typealias CompletionHandler = (Error?) -> Void
    
    
    // MARK: - Coding
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned by dataTask")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let albumsData = try decoder.decode([String : Album].self, from: data)
            
                for album in albumsData {
                    self.albums.append(album.value)
                }
            } catch {
                NSLog("Error decoding or saving data from Firebase: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let putRequest = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        var urlRequest = URLRequest(url: putRequest)
        urlRequest.httpMethod = "PUT"
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { _, _, error in
            if let error = error {
                NSLog("Error sending (PUT) album to the server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
        
    }
    
    // MARK: - CRUD
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(newAlbum)
        put(album: newAlbum)
    }
    
    func createSong(duration: String, id: String, name: String) -> Song {
        let newSong = Song(duration: duration, id: id, name: name)
        return newSong
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        var album = album
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.id = id
        album.name = name
        album.songs = songs
        put(album: album)
    }
    
//    func testDecodingExampleAlbum() {
//        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
//        let data = try! Data(contentsOf: urlPath)
//
//        let decoder = JSONDecoder()
//        let weezer = try! decoder.decode(Album.self, from: data)
//
//        print("\(weezer)")
//    }
    
//    func testEncodingExampleAlbum() {
//        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
//        let data = try! Data(contentsOf: urlPath)
//
//        let decoder = JSONDecoder()
//        let weezer = try! decoder.decode(Album.self, from: data)
//
//        print("\(weezer)")
//
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//
//        let weezerData = try! encoder.encode(weezer)
//
//        let dataAsString = String(data: weezerData, encoding: .utf8)!
//        print(dataAsString)
//    }
}
