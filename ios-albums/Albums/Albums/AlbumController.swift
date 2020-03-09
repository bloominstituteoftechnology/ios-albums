//
//  AlbumController.swift
//  Albums
//
//  Created by Craig Swanson on 1/15/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    var albums: [Album] = []
    private let baseURL: URL = URL(string: "https://mymovies-1962c.firebaseio.com/")!
    
    
    // MARK: - Read/fetch from server
    func getAlbums(completion: @escaping (Error?) -> () = {_ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            guard error == nil else {
                print("Error fetching albums from server: \(error!)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data was returned by data task")
                completion(NSError())
                return
            }
            
            do {
                self.albums = Array(try JSONDecoder().decode([String : Album].self, from: data).values)
                completion(nil)
            } catch {
                print("Error decoding albums from json: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    // MARK: - Put to server
    func put(album: Album, completion: @escaping (Error?) -> () = {_ in }) {
        let identifier = album.id
        let requestURL = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            print("Error encoding album: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error PUTing movie to server: \(error!)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    // MARK: - Create album
    func createAlbum(for album: Album) {
        albums.append(album)
        put(album: album)
    }
    
    // MARK: - Create song
    func createSong(duration: String, id: String, name: String) -> Song {
        let newSong = Song(duration: duration, id: id, name: name)
        return newSong
    }
    
    // MARK: - Update album
    func update(for album: Album) {
        if let row = self.albums.firstIndex(where: {$0.id == album.id}) {
            albums[row].songs = album.songs
        }
        put(album: album)
    }
}
