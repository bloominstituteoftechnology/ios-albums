//
//  AlbumController.swift
//  Album
//
//  Created by Lydia Zhang on 4/6/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class AlbumController {
    var albums = [Album]()
    var baseURL = URL(string: "https://album-e5365.firebaseio.com/")!

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func exampleAlbumDecode(){
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {return}
        do {
            let album = try self.decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            NSLog("Example Decode Error")
        }
    }
    func exampleAlbumEncode(){
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {return}
        encoder.outputFormatting = [.prettyPrinted]
        
        do {
            let album = try self.decoder.decode(Album.self, from: data)
            let albums = try encoder.encode(album)
            print(albums)
        } catch {
            NSLog("Example Encode Error")
        }
    }
    
    func fetchAlbum(completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { data, _ , error in
            if let error = error {
                NSLog("Fetching Error")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No fetching data")
                completion(error)
                return
            }
            do {
                let albums = try self.decoder.decode([String: Album].self, from: data)
                self.albums = Array(albums.values)
                completion(nil)
                return
            } catch {
                NSLog("Decode Error when fetching")
                completion(error)
                return
            }
        }.resume()
    }
    
    func putAlbumsToServer(album: Album, completion: @escaping (Error?) -> Void) {
        let id = album.id
        let albumURL = baseURL.appendingPathComponent(id.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: albumURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            let json = try self.encoder.encode(album)
            request.httpBody = json
        } catch {
            NSLog("Error encoding when putting")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Put error")
                completion(error)
                return
            }
        }.resume()
    }
    
    func createAlbum(name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let id = UUID()
        let album = Album(id: id, name: name, coverArt: coverArt, artist: artist, genres: genres, songs: songs)
        self.albums.append(album)
        putAlbumsToServer(album: album) {error in
            if let error = error {
                NSLog("Create error: \(error)")
                return
            }
        }
    }
    
    func updateAlbum(album: Album, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let new = Album(id: album.id, name: name, coverArt: coverArt, artist: artist, genres: genres, songs: songs)
        
        if let index = albums.firstIndex(of: album) {
            albums[index] = new
        }
        putAlbumsToServer(album: new) { error in
            if let error = error {
                NSLog("Update error: \(error)")
                return
            }
        }
    }
    
    func createSong(title: String, duration: String) -> Song {
        let id = UUID()
        let song = Song(id: id, name: title, duration: duration)
        return song
    }
}
