//
//  AlbumController.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

class AlbumController {
    var albums: [Album] = []
    let baseURL = URL(string: "https://lambda-albums.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void = {_ in }) {
        let requestUrl = baseURL.appendingPathComponent("albums").appendingPathExtension("json")
        let request = URLRequest(url: requestUrl)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Data task error: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            do {
                let albumsDic = try JSONDecoder().decode([String : Album].self, from: data)
                for (_, value) in albumsDic {
                    self.albums.append(value)
                }
            } catch {
                print("Error encoding fetched albums: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func put(album: Album) {
        let requestURL = baseURL.appendingPathComponent("albums").appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            print("Error encoding album: \(error)")
        }
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error PUTting album: \(error)")
                return
            }
            print("Album sent")
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(duration: String, id: UUID, title: String) -> Song {
        return Song(duration: duration, id: id, title: title)
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        guard album.id == id else {
            // these aren't actually the same album
            return
        }
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        put(album: newAlbum)
        getAlbums()
    }
    
    
    // MARK: - Test methods
    func testDecodingExampleAlbum() -> Album? {
        var album: Album
        do {
            let data = try Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))
            album = try JSONDecoder().decode(Album.self, from: data)
            print("decoded JSON")
            return album
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
    
    func testEncodingExampleAlbum(_ album: Album) -> Data? {
        do {
            let json = try JSONEncoder().encode(album)
            print("JSON: \(json)")
            return json
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
}
