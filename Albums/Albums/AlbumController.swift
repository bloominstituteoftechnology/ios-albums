//
//  AlbumController.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://lambda-albums-nate.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        
        let jsonURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: jsonURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error connecting to server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data from server")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([String: Album].self, from: data)
                self.albums = decodedData.compactMap({ $0.value })
                completion(nil)
            } catch {
                NSLog("Error decoding JSON.")
                completion(error)
            }
        }.resume()
    }
    
    func put(album: Album) {
    
        let jsonURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: jsonURL)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(album)
        } catch {
            NSLog("Error encoding data")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error putting to server: \(error)")
                return
            }
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: URL? = nil, genres: String, name: String, songs: [Song]? = nil) {
        let genresArray = genres.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
        let album = Album(artist: artist, coverArt: coverArt, genres: genresArray, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(name: String, duration: String) -> Song {
        return Song(duration: duration, name: name)
    }
    
    func update(album: Album, artist: String, coverArt: URL? = nil, genres: String, id: String, name: String, songs: [Song]? = nil) {
        let genresArray = genres.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genresArray
        album.id = id
        album.name = name
        album.songs = songs
    }

    
    
//    let path = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
//
//    @discardableResult func testDecodingExampleAlbum() -> Album? {
//
//        let decoder = JSONDecoder()
//        do {
//            let data = try! Data(contentsOf: path)
//            return try decoder.decode(Album.self, from: data)
//        } catch {
//            print("There was an error decoding data")
//            return nil
//        }
//    }
//
//    func testEncodingExampleAlbum() {
//        guard let album = testDecodingExampleAlbum() else { return }
//
//        let encoder = JSONEncoder()
//        do {
//            let encodedData = try encoder.encode(album)
//            print(String(data: encodedData, encoding: .utf8))
//        } catch {
//            print("Error encoding data")
//            return
//        }
//    }
}
