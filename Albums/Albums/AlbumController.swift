//
//  AlbumController.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class AlbumController {
    
    // Data source for the application
    var albums: [Album] = []
  
    private let baseURL = URL(string: "https://nelson-ios-journal.firebaseio.com/")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getAlbums(completion: @escaping(Error?) -> Void){
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from the data task")
                completion(NSError())
                return
            }
            
            DispatchQueue.main.async {
                
                do {
                    self.albums = try JSONDecoder().decode([String: Album].self, from: data).map({$0.value})
                    
                } catch {
                    NSLog("Error decoding album: \(error)")
                }
            }
            }.resume()
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        
        do {
            let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = "PUT"
            
            let body = try JSONEncoder().encode(album)
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { (_, _, error) in
                if let error = error {
                    NSLog("Error saving album: \(error)")
                }
                completion(error)
                }.resume()
            
        } catch {
            NSLog("Error encoding entry: \(error)")
            completion(error)
            return
        }
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        
        // Initialize an Album object
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        
        // Add new album to the albums array
        albums.append(newAlbum)
        
        // Save to the server
        put(album: newAlbum)
    }
    
    func createSong(duration: String, id: String, name: String) -> Song {
        
        // Initialize a Song object
        let newSong = Song(duration: duration, id: id, name: name)
        return newSong
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        
        var updatedAlbum = album
        
        updatedAlbum.artist = artist
        updatedAlbum.coverArt = coverArt
        updatedAlbum.genres = genres
        updatedAlbum.id = id
        updatedAlbum.name = name
        updatedAlbum.songs = songs
        
        put(album: updatedAlbum)
        
    }
    
    
   
    func testDecodingExampleAlbum() {
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("URL not functioning")
            return
        }
        
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            var album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            
            print(album)
            print("SUCCESS!")
        } catch {
            print("Error retrieving data: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("URL not functioning")
            return
        }
        
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            var album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print(album)
            let encodedAlbum = try JSONEncoder().encode(album)
            print(String(data: encodedAlbum, encoding: .utf8)!)
            print("SUCCESS!")
        } catch {
            print("Error retrieving data: \(error)")
        }
        
        
        
    }
    
    
}
