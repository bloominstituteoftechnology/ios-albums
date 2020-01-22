//
//  AlbumController.swift
//  Album
//
//  Created by Christy Hicks on 1/21/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

class AlbumController {
    // MARK: - Properties
    var albums: [Album] = []
    let baseURL = URL(string: "https://journal-cd569.firebaseio.com/albums")!
    
    // MARK: - Methods
    func getAlbums(completion: @escaping ((Error?) -> Void) = { _ in}) {
        
        URLSession.shared.dataTask(with: baseURL.appendingPathExtension("json")) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                //_ = String(data: data, encoding: .utf8)
                let albums = Array(try JSONDecoder().decode([String: Album].self, from: data).values)
                
                self.albums = albums
                completion(nil)
            } catch {
                print(error)
                completion(error)
            }
        }.resume()
    }
    
    func createAlbum(with name: String, artist: String, coverArtURLs: [URL], genres: [String], songs: [Song]) {
        
        let album = Album(name: name, artist: artist, coverArt: coverArtURLs, genres: genres, songs: songs)
        albums.append(album)
        send(album: album)
    }
    
    func createSong(with title: String, duration: String) -> Song {
        
        return Song(title: title, duration: duration)
    }
    
    func update(album: Album, with name: String, artist: String, coverArtURLs: [URL], genres: [String], songs: [Song]) {
        
        album.name = name
        album.artist = artist
        album.coverArt = coverArtURLs
        album.genres = genres
        album.songs = songs
        
        send(album: album)
    }
    
    func send(album: Album) {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(album.identifier.uuidString).appendingPathExtension("json"))
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            print(error)
        }
        
        request.httpMethod = "PUT"
        URLSession.shared.dataTask(with: request) { (data, _, error) in
        }.resume()
    }
}
