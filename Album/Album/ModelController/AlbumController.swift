//
//  AlbumController.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    let baseURL = URL(string: "https://album-300b5.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data")
                return
            }
            do {
                let albumDict = try JSONDecoder().decode([String : Album].self, from: data)
                self.albums = albumDict.map({ $0.value })
                print(self.albums)
                completion(nil)
            } catch {
                completion(error)
                return
            }
        }.resume()
    }
    
    func put(album: Album) {
        let id = album.id
        let requestURL = baseURL.appendingPathComponent(id).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        do {
            let data = try JSONEncoder().encode(album)
            print(String(data: data, encoding: .utf8))
            request.httpBody = data
        } catch {
            print ("Error encoding album to PUT in server: \(error)")
        }
        
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print ("Error PUTing album in server: \(error)")
            }
        }.resume()
    }
    
    func createAlbum(artist: String, genres: [String], name: String) {
        let newAlbum = Album(artist: artist, genres: genres, name: name)
        albums.append(newAlbum)
        print(albums)
        put(album: newAlbum)
    }
    
    func createSong(duration: String, title: String) -> Song {
        let newSong = Song(duration: duration, title: title)
        return newSong
    }
    
    func update(album: inout Album, artist: String, genres: [String], name: String) {
        album.artist = artist
        album.genres = genres
        album.name = name
        put(album: album)
    }
    
    func testDecodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let album = try! JSONDecoder().decode(Album.self, from: data)
        //print(album)
    }
    
    
    func testEncodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let album = try! JSONDecoder().decode(Album.self, from: data)
        
        let newData = try! JSONEncoder().encode(album)
        print(String(data: newData, encoding: .utf8))
    }
}

enum HTTPMethod: String{
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
