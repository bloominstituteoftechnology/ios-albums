//
//  AlbumController.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit

class AlbumController {
    
    var albums: [Album] = []
    
    var baseURL = URL(string: "https://albums-4cad2.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let decodedDict = try jsonDecoder.decode([String: Album].self, from: data)
                let albums = Array(decodedDict.values)
                self.albums = albums
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
            
            }.resume()
        
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void = { _ in }) {
        let url = baseURL.appendingPathComponent(album.id ?? UUID().uuidString)
        let urlJSON = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(album)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.albums.append(album)
            completion(nil)
            }.resume()
        
    }
    
    func createAlbum(withArtist artist: String, andAlbum name: String, andGenre genres: [String], andArt coverArt: String) {
        let album = Album(artist: artist, name: name, genres: genres, coverArt: [["url": coverArt]])
        
        albums.append(album)
        put(album: album)
    }
    
    func createSong(withTitle title: String, andDuration duration: String, completion: @escaping (Error?) -> Void) -> Song {
        let song = Song(songs: [title: duration])
        
        return song
    }
    
    func update(album: Album, artist: String, name: String, genres: [String], coverArt: String, completion: @escaping (Error?) -> Void) {
        
        guard let index = albums.index(of: album) else { return }
        albums[index].artist = artist
        albums[index].name = name
        albums[index].genres = genres
        albums[index].coverArt = [["url": coverArt]]
        
        let updatedAlbums = albums[index]
        
        put(album: updatedAlbums, completion: completion)
        
    }
    
   func testDecodingExampleAlbum() {
        guard let jsonURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: ".json" ) else { return }
        let data = try! Data(contentsOf: jsonURL)

        let jsonDecoder = JSONDecoder()
    
        do {
            let decoded = try jsonDecoder.decode(Song.self, from: data)
            print(decoded)
        } catch {
            NSLog("\(error)")
            print("Error: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let jsonURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: ".json" ) else { return }
        let data = try! Data(contentsOf: jsonURL)
        
        var song: Song?
        
        let jsonDecoder = JSONDecoder()
        
        do {
            song = try jsonDecoder.decode(Song.self, from: data)
            print("Decoded: \(song!)")
        } catch {
            NSLog("\(error)")
        }
       
        let encoder = JSONEncoder()
        
        do {
            let encoded = try encoder.encode(song!)
            print("Encoded: \(encoded)")
        } catch {
            NSLog("Error encoding album: \(error)")
        }

    }
    
}
