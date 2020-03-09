//
//  AlbumController.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
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
    let baseURL = URL(string: "https://albums-e0f84.firebaseio.com/")!
    
    func getAlbums(completion: @escaping () -> Void = { }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error getting albums from server: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                self.albums = try decoder.decode([String: Album].self, from: data).map({ $0.value })
            } catch {
                NSLog("Error decoding: \(error)")
            }
            completion()
        }.resume()
    }
    
    
    func put(album: Album?, completion: @escaping () -> Void = { }) {
        
        guard let album = album else {
            NSLog("Album is nil")
            completion()
            return
        }
        
        let identifier = album.id
        
        let requestURL = baseURL
            .appendingPathComponent(identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album: \(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error PUTting album: \(error)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: [CoverArtURL], genres: [String], id: String, name: String, songs: [Song]) -> Album {
        
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        
        put(album: album)
        return album
    }
    
    func createSong(duration: SongDuration, id: String, name: SongName) -> Song {
        let song = Song(duration: duration, id: id, name: name)
        return song
    }
    
    func update(album: Album, artist: String, coverArt: [CoverArtURL], genres: [String], id: String, name: String, songs: [Song]) {
        var newAlbum = album
        newAlbum.artist = artist
        newAlbum.coverArt = coverArt
        newAlbum.genres = genres
        newAlbum.id = id
        newAlbum.name = name
        newAlbum.songs = songs
        
        put(album: newAlbum)
    }
    
    
    func testDecodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let _ = try JSONDecoder().decode(Album.self, from: data)
            } catch {
                print("Error. Unable to decode json file.")
            }
        } else {
            print("Error. Unable to find json file.")
        }
    }
    
    func testEncodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let album = try JSONDecoder().decode(Album.self, from: data)
                let _ = try JSONEncoder().encode(album)
            } catch {
                print("Error. Unable to encode json file.")
            }
        } else {
            print("Error. Unable to find json file.")
        }
    }
}

