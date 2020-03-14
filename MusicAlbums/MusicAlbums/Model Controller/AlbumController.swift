//
//  AlbumController.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class AlbumController {
    
    // type alias - sort of shortcut for function - put outsude class to use throughout class.
//    typealias CompletionHandler = (Error?) -> ()
    
    var albums = [Album]()
    let baseURL = URL(string: "https://albums-eeaad.firebaseio.com/")
    
    // Get Albums
    func getAlbumsFromServer(completion: @escaping (Error?) -> ()) {
        guard let requestURL = baseURL?.appendingPathExtension("json") else { return }
        URLSession.shared.dataTask(with: requestURL) {  (data, response, error) in
            guard error == nil else {
                print("Error Getting Albums from the server: \(error!)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let data = data else {
                print("No Data retured from Data Task")
                DispatchQueue.main.async {
                    completion(NSError())
                }
                return
            }
            do {
                let albumsData = try JSONDecoder().decode([String: Album].self, from: data)
                self.albums = Array(albumsData.values)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                print("Error Decoding Album: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
        }.resume()
    }
    
    
    // Put Albums in Server
    func putAlbumsInServer(album: Album, completion: @escaping (Error?) -> () = { error in}) {
        guard let requestURL = baseURL?.appendingPathComponent(album.id).appendingPathExtension("json") else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let albumData = try JSONEncoder().encode(album)
            request.httpBody = albumData
        } catch {
            print("Error encoding entry: \(error)")
            completion(error)
            return
        }
        
        // send Album to Firebase
         URLSession.shared.dataTask(with: request) { (data, _, error) in
             guard error == nil else {
                 print("Error PUTing tasks to server: \(error!)")
                 DispatchQueue.main.async {
                     completion(error)
                 }
                 return
             }
             DispatchQueue.main.async {
                     completion(nil)
             }
         }.resume()
    }
    
    // Create Albums
    func createAlbum(id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(newAlbum)
        putAlbumsInServer(album: newAlbum)
    }
    
    
    // Create songs
    
    func createSong(id: String, name: String, duration: String) -> Song {
        return Song(id: id, duration: duration, name: name)
    }
    
    // Update Songs
    func update(album: Album, id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]){
        guard let albumList = albums.firstIndex(of: album) else { return }
        var album = album
        album.id = id
        album.name = name
        album.artist = artist
        album.genres = genres
        album.coverArt = coverArt
        album.songs = songs
        albums[albumList] = album
        putAlbumsInServer(album: album)
        
    }
    
    // Test functionality ( encoding/decoding ) using a local .json file 
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    
        do {
            let data = try Data(contentsOf: urlPath)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: data)
            print(decodedAlbum)
        } catch {
            print("Error returned decoding album objects: \(error)")
            return
        }
        
    }
    
    func testEncodingExample() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"),
            let data = try? Data(contentsOf: urlPath) else { return }
        
        do {
            let album = try JSONDecoder().decode(Album.self, from: data)
            let albumData = try JSONEncoder().encode(album)
            print(String(data: albumData, encoding: .utf8)!)
        } catch let decodeError {
            print(decodeError)
        }
        
    }
    
}
