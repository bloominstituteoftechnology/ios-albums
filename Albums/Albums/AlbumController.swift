//
//  AlbumController.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class AlbumController {

    var albums: [Album] = []
    let baseURL = URL(string: "https://movies-e041c.firebaseio.com/.json")!
    var album: Album?

//    func testEncodingExampleAlbum() {
//        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return}
//        let data = try! Data(contentsOf: url)
//        let decoder = JSONDecoder()
//        let album = try! decoder.decode(Album.self, from: data)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        do {
//            let encoder = JSONEncoder()
//            request.httpBody = try encoder.encode(album)
//        } catch {
//            NSLog("Error encoding data")
//            return
//        }
//
//
//
//
//        createAlbum(artist: album.artist, coverArt: album.coverArt, genres: "pop", name: album.name, songs: album.songs)
//        print(albums)
//    }

    func putOnServer(album: Album) {

        let jsonURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")

        var request = URLRequest(url: jsonURL)
        request.httpMethod = "PUT"

        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(album)
        } catch {
            NSLog("Error encoding data: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error putting on server: \(error)")
                return
            }
            }.resume()
    }

    func getAlbums(completion: @escaping (Error?) -> Void) {

        let url = baseURL.appendingPathExtension("json")

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, _, error) in

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
                let albums = decodedData.compactMap({ $0.value })
                self.albums = albums
                completion(nil)
            } catch {
                NSLog("Error decoding JSON.")
                completion(error)
            }
            }.resume()
    }
    func createAlbum(artist: String, coverArt: [URL], genres: String, name: String, songs: [Song]? = nil) {
        let genresArray = genres.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
        let album = Album(artist: artist, coverArt: coverArt, genres: genresArray, name: name, songs: songs!)
        albums.append(album)
        putOnServer(album: album)
    }

    func createSong(name: String, duration: String) -> Song {
        return Song(duration: duration, name: name)
    }

    func update(album: Album, artist: String, coverArt: [URL], genres: String, id: String, name: String, songs: [Song]? = nil) -> Album {
        let genresArray = genres.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
        var updateAlbum = album

        updateAlbum.artist = artist
        updateAlbum.coverArt = coverArt
        updateAlbum.genres = genresArray
        updateAlbum.id = id
        updateAlbum.name = name
        updateAlbum.songs = songs

        return updateAlbum
    }

}
