//
//  AlbumController.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/17/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import Foundation


class AlbumController {
    let baseURL = URL(string: "https://album-bd69b.firebaseio.com/")!
    var albums: [Album] = []
    
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func testDecodingExampleAlbum() {
        
        guard let url = persistentFileURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let exampleAlbum = try JSONDecoder().decode(Album.self, from: data)
            print(exampleAlbum.coverArt)
        } catch {
            print("Error decoding data: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let url = persistentFileURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let exampleAlbum = try JSONDecoder().decode(Album.self, from: data)
            
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let albumData = try jsonEncoder.encode(exampleAlbum)
            print(String(data: albumData, encoding: .utf8)!)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            print(request)
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data return from  data task.")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decoded = try jsonDecoder.decode([String: Album].self, from: data).map { $0.value }
                self.albums = decoded
                completion(nil)
            } catch {
                print("Unable to decode data into an object of type [Album]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping () -> Void = {
        }) {
        
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            let encoded = try JSONEncoder().encode(album)
            request.httpBody = encoded
        } catch {
            print(error)
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            
            if let error = error {
                print("Error PUTting data: \(error)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    func createAlbum(id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let album = Album(artist: artist, coverArt: coverArt, id: id, genres: genres, name: name, songs: songs)
        
        albums.append(album)
        
        put(album: album)
    }
    
    func createSong(id: String, name: String, duration: String) -> Song {
        return Song(duration: duration, id: id, name: name)
    }
    
    func update(album: Album, id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        guard let index = albums.firstIndex(of: album) else { return }
        
        var album = album
        album.id = id
        album.name = name
        album.artist = artist
        album.genres = genres
        album.coverArt = coverArt
        album.songs = songs
        
        albums[index] = album
        put(album: album)
    }
}
