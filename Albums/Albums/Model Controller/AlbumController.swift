//
//  AlbumController.swift
//  Albums
//
//  Created by Lisa Sampson on 9/2/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

class AlbumController {
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let url = AlbumController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error getting JSON data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not recieved.")
                completion(error)
                return
            }
            
            do {
                let decodedAlbums = try JSONDecoder().decode([String: Album].self, from: data)
                let albums = decodedAlbums.map { $0.value }
                self.albums = albums
                completion(nil)
            }
            catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func put(album: Album) {
        let url = AlbumController.baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        }
        catch {
            NSLog("Error encoding album: \(album) \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
            }
        }.resume()
    }
    
    func createAlbum(albumCover: [String], artist: String, albumName: String, genres: [String], id: String, songs: [Song]) {
        
        let newAlbum = Album(albumCover: albumCover, artist: artist, albumName: albumName, genres: genres, id: id, songs: songs)
        
        albums.append(newAlbum)
        
        put(album: newAlbum)
    }
    
    func createSong(id: String, duration: String, songName: String) -> Song {
        
        let newSong = Song(id: id, duration: duration, songName: songName)
        
        return newSong
    }
    
    func update(album: Album, albumCover: [String], artist: String, albumName: String, genres: [String], songs: [Song]) {
        
        guard let index = albums.index(of: album) else { return }
        
        var scratch = albums[index]
        scratch.albumCover = albumCover
        scratch.artist = artist
        scratch.albumName = albumName
        scratch.genres = genres
        scratch.songs = songs
        
        albums.remove(at: index)
        albums.insert(scratch, at: index)
        
        put(album: scratch)
    }
    
    var albums: [Album] = []
    static let baseURL = URL(string: "https://advanced-codable.firebaseio.com/")!
    
    // MARK: - Testing
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ; return }
        
        do {
            let exampleData = try Data(contentsOf: url)
            
            _ = try JSONDecoder().decode(Album.self, from: exampleData)
            
            print("Success!")
        }
        catch {
            print("Error getting data or decoding data: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ; return }

        do {
            let exampleData = try Data(contentsOf: url)

            let album = try JSONDecoder().decode(Album.self, from: exampleData)

            _ = try JSONEncoder().encode(album)

            print("Success!")
        }
        catch {
            print("Error getting data or decoding data: \(error)")
        }
    }
}
