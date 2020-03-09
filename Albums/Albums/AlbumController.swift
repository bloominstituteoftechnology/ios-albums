//
//  AlbumController.swift
//  Albums
//
//  Created by Michael on 2/10/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class AlbumController {
    
    let baseURL = URL(string: "https://albums-be129.firebaseio.com/")!
    
    var albums: [Album] = []
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                NSLog("Error getting albums from server. \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let data = data else {
                NSLog("No data returned by data task")
                DispatchQueue.main.async {
                    completion(NSError())
                }
                return
            }
            do {
                let fetchedAlbums = Array(try JSONDecoder().decode([String : Album].self, from: data).values)
                for album in fetchedAlbums {
                    self.albums.append(album)
                }
            } catch {
                NSLog("Error decoding Album objects: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let uuid = UUID().uuidString
        let requestURL = baseURL.appendingPathComponent("\(uuid)").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        var newAlbum = album
        newAlbum.id = uuid
        
        do {
            
            let jsonEncodedAlbum = try JSONEncoder().encode(newAlbum)
            request.httpBody = jsonEncodedAlbum
        } catch {
            NSLog("Error encoding album \(album): \(error)")
            DispatchQueue.main.async {
                completion(error)
            }
            return
        }
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error PUTing album to server \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, name: name, songs: songs)
        albums.append(newAlbum)
        put(album: newAlbum)
    }
    
    func createSong(duration: String, name: String) -> Song {
        var newSong = Song(duration: duration, name: name)
        newSong.duration = duration
        newSong.id = UUID().uuidString
        newSong.name = name
        return newSong
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        var updatedAlbum = album
        updatedAlbum.artist = artist
        updatedAlbum.coverArt = coverArt
        updatedAlbum.genres = genres
        updatedAlbum.name = name
        updatedAlbum.songs = songs
        put(album: updatedAlbum)
    }
    
    func testDecodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
            
        do {
            let album = try decoder.decode(Album.self, from: data)
            print("This is the decoded album \(album)")
        } catch {
            NSLog("Error decoding album")
        }
    }
    
    func testEncodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
            
        do {
            let album = try decoder.decode(Album.self, from: data)
            print("This is the encoded album \(album)")
        } catch {
            NSLog("Error encoding album")
        }
    }
}

