//
//  AlbumController.swift
//  Albums
//
//  Created by Sergey Osipyan on 1/28/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import Foundation

class AlbumController {
    
    var temp: Album?
    var albums: [Album] = []
    typealias ComplitionHandler = (Error?) -> Void
    let baseURL: URL = URL(string: "https://codablealbum.firebaseio.com/")!
    
    func getAlbums(complition: @escaping ComplitionHandler = { _ in }) {
     
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("No fetching tasks \(error)")
                complition(error)
                return
            }
            guard let data = data else {
                NSLog("No data")
                complition(NSError())
                return
            }
        
            do {
                let albumsResualt = try JSONDecoder().decode([String: Album].self, from: data).map({$0.value})
                self.albums = albumsResualt
                
                
            }catch {
                
                NSLog("Error")
                complition(error)
            }
        
        }.resume()
    }
    
    func put(album: Album, comletion: @escaping ComplitionHandler = { _ in }){
        
         let requestURL = baseURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Unable to encode \(album): \(error)")
            comletion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("No fetching tasks \(error)")
                comletion(error)
            }
            }.resume()
        
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Album.Song]) {
        
        let newAlbum = Album(name: name, artist: artist, genres: genres, coverArt: coverArt)
        
       albums.append(newAlbum)
       put(album: newAlbum)
        
    }
    func createSong(duration: String, id: String, name: String) -> Album.Song {
        
        let newSong = Album.Song(title: name, duration: duration, id: id)
        
        return newSong
    }
    
    func update(album: Album, with artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Album.Song] ) {
        
//        album.artist = artist
//        album.coverArt = coverArt
//        album.genres = genres
        
      
        
    }
    func testDecodingExampleAlbum(){
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad")
            fatalError()
        }
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print(album)
            temp = album
            
        } catch {
            
            print("error geting data \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad")
            fatalError()
        }
        
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print(album)
            let encodeAlbum = try JSONEncoder().encode(album)
            print(String(data: encodeAlbum, encoding: .utf8)!)
        } catch {
            
             print("error encoding data \(error)")
        }
        
    }
}
