//
//  AlbumController.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit
import Foundation

enum HTTPMethod: String {
    case put = "PUT"
    case delete = "DELETE"
}

class AlbumController {
    
    func testDecodingExampleAlbum() {
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        do {
            let testAlbum = try decoder.decode(Album.self, from: data)
            print("\(testAlbum)")
        } catch {
            NSLog("Error decoding test album: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        var testAlbum: Album?
        
        do {
            testAlbum = try decoder.decode(Album.self, from: data)
            print(testAlbum!)
        } catch {
            NSLog("Error decoding test album: \(error)")
        }
        
        let jsonEncoder = JSONEncoder()
        
        do {
          let testAlbumData = try jsonEncoder.encode(testAlbum!)
            print(testAlbumData)
        } catch {
            NSLog("Error encoding person: \(error)")
        }
    }
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        
        let url = baseURL.appendingPathExtension("json")
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching album: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task ")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let albums = try jsonDecoder.decode([String : Album].self, from: data).map( { $0.value } )
                
                self.albums = albums
                
                completion(nil)
            } catch {
                NSLog("Error decoding albums: \(error)")
                completion(error)
            }
        }
        dataTask.resume()
    }
    
    func put(_ album: Album, completion: @escaping (Error?) -> Void = { _ in }) {
        
        let identifier = album.id
        
        let url = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let albumData = try jsonEncoder.encode(album)
            urlRequest.httpBody = albumData
        } catch {
            NSLog("Error encoding album: \(error)")
            completion(error)
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error putting album to server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        dataTask.resume()
    }
    
    func createAlbum(artist: String, name: String, genres: [String], coverArt: [URL], songs: [Song]) {
        
        let album = Album(artist: artist, name: name, genres: genres, coverArt: coverArt, songs: songs)
        
        albums.append(album)
        put(album)
    }
    
    func createSong(name: String, duration: String) -> Song {
        
        let song = Song(name: name, duration: duration)
        
        return song
    }
    
    func update(album: Album, artist: String, name: String, genres: [String], coverArt: [URL], songs: [Song], id: String) {
        guard let index = albums.index(of: album) else { return }
        
        albums[index].artist = artist
        albums[index].name = name
        albums[index].genres = genres
        albums[index].coverArt = coverArt
        albums[index].songs = songs
        albums[index].id = id
        
        put(album)
    }
    
    // MARK: - Properties
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://mosesalbums.firebaseio.com/")!
    
}
