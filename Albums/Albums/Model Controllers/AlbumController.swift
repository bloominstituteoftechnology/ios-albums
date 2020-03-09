//
//  AlbumController.swift
//  Albums
//
//  Created by morse on 12/2/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

class AlbumController {
    
    let baseURL = URL(string: "https://albums-e99bf.firebaseio.com/")!
    var albums: [Album] = []
    
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    struct HTTPMethod {
        static let get = "GET"
        static let put = "PUT"
        static let post = "POST"
        static let delete = "DELETE"
    }
    
    func testDecodingExampleAlbum() {
        
        guard let url = persistentFileURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let exampleAlbum = try JSONDecoder().decode(Album.self, from: data)
            print(exampleAlbum.coverArt)
        } catch {
            print("Error retrieving data: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let url = persistentFileURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let exampleAlbum = try JSONDecoder().decode(Album.self, from: data)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let albumData = try encoder.encode(exampleAlbum)
            print(exampleAlbum.coverArt)
            print(String(data: albumData, encoding: .utf8)!)
        } catch {
            print("Error retrieving data: \(error)")
        }
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
//            print(request)
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(nil)
                return
            }
//            print(request)
//            print(String(data: data, encoding: .utf8)!)
            
            let jsonDecoder = JSONDecoder()
            do {
                let decoded = try jsonDecoder.decode([String: Album].self, from: data).map { $0.value }
                self.albums = decoded
                completion(nil)
            } catch {
                print("Unable to decode data into object of type [Album]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping () -> Void = { }) {
        
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put
//        print(request)
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
        let album = Album(id: id, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: songs)
        
        albums.append(album)
//        print(album)
//        print(albums[0].name)
        put(album: album)
    }
    
    func createSong(id: String, name: String, duration: String) -> Song {
        return Song(id: id, name: name, duration: duration)
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
