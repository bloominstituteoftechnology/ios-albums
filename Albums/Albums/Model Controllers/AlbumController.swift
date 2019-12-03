//
//  AlbumController.swift
//  Albums
//
//  Created by Dennis Rudolph on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    var baseURL: URL = URL(string: "https://albums-62726.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("Error fetching albums: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                print("No data")
                completion(error)
                return
            }

            do {
                let albums = try JSONDecoder().decode([String: Album].self, from: data)
                self.albums = albums.map({ $0.value })
            } catch {
                print("Error decoding albums: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func put(album: Album) {
        let requestURL = baseURL.appendingPathComponent(album.id.uuidString)

        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let bodyAlbum = try JSONEncoder().encode(album)
            request.httpBody = bodyAlbum
        } catch {
            print("Error encoding album: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error putting albums on database: \(error)")
            } else {
                print("Success")
            }
        }.resume()
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: UUID = UUID(), name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(duration: String, id: UUID = UUID(), name: String) -> Song {
        let song = Song(duration: duration, id: id, name: name)
        return song
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        guard let albumIndex = albums.firstIndex(of: album) else { return }
        albums[albumIndex].artist = artist
        albums[albumIndex].coverArt = coverArt
        albums[albumIndex].genres = genres
        albums[albumIndex].name = name
        albums[albumIndex].songs = songs
        put(album: album)
    }
    
    func testDecodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print(album)
        } catch {
            print("Decoding Error")
        }
    }
    
    func testEncodingExampleAlbum() {
        let data = try! Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))

        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let albumData = try encoder.encode(album)

            let dataString = String(data: albumData, encoding: .utf8)!
            print(dataString)
        } catch {
            print("Encoding Error")
        }
    }
}

