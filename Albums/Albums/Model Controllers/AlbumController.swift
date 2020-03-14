//
//  AlbumController.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    private let baseURL = URL(string: "https://lambdaalbumscodableproject.firebaseio.com/")
    
    func createAlbum(artist: String, coverArt: [URL], genres:[String], id: String, name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(id: String, name: String, duration: String) -> Song {
        let song = Song(id: id, name: name, duration: duration)
        return song
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres:[String], id: String, name: String, songs: [Song]) {
        
        guard let index = albums.firstIndex(of: album) else { return }
        
        albums[index].artist = artist
        albums[index].coverArt = coverArt
        albums[index].genres = genres
        albums[index].name = name
        albums[index].songs = songs
        put(album: album)
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void = { _ in }) {
        guard let baseURL = baseURL else { return }
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print("Error PUTing album to the server: \(error!)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        guard let baseURL = baseURL else { return }
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _,  error in
            guard error == nil else {
                print("Error getting albums from server: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                print("No data returned")
                completion(NSError())
                return
            }

            do {
                let decodedAlbums = Array(try JSONDecoder().decode([String : Album].self, from: data).values)
                self.albums = decodedAlbums
                completion(nil)
            } catch {
                print("Error decoding album: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
            
        do {
            let dataFromURL = try Data(contentsOf: urlPath)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: dataFromURL)
            //let decodedSongs: [Song] = try JSONDecoder().decode([Song].self, from: dataFromURL)
            print(decodedAlbum)
        } catch {
            print("Error decoding album objects: \(error)")
            return
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
            
        do {
            let dataFromURL = try Data(contentsOf: urlPath)
            let encodedAlbum = try JSONEncoder().encode(dataFromURL)
            let stringAlbum = String(data: encodedAlbum, encoding: .utf8)
            print(stringAlbum)
        } catch {
            print("Error encoding album objects: \(error)")
            return
        }
    }
}
