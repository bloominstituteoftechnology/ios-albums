//
//  AlbumController.swift
//  Albums
//
//  Created by Marissa Gonzales on 5/7/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

// Error Handling
enum NetworkError: Error {
    case noData, failedSignUp, failedLogin, noToken
    case notSignedIn, failedPost, failedFetch, success
}
// HTTP method handling
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class AlbumController {
    
    typealias completionHandler = (NetworkError?) -> Void
    var albums: [Album] = []
    
    private let baseURL = URL(string: "https://nelson-ios-journal.firebaseio.com/")!
    
    func fetchAlbums(completion: @escaping (NetworkError?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("json")
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                print("Error fetching albums: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error fetching data")
                completion(.failedFetch)
                return
            } 
            DispatchQueue.main.async {
                do {
                    self.albums = try JSONDecoder().decode([String:Album].self, from: data).map(){$0.value}
                    completion(.success)
                    return
                } catch {
                    print("Error decoding album: \(error)")
                    completion(.failedFetch)
                }
            }
        }
    }
    func putAlbums(album: Album, completion: @escaping completionHandler = { _ in }) {
        
        do {
            let requestURL = baseURL.appendingPathComponent(album.id).appendingPathComponent("json")
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = HTTPMethod.put.rawValue
            
            let body = try JSONEncoder().encode(album)
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { (_, _, error) in
                if let error = error {
                    print("Error saving album: \(error)")
                    
                }
                completion(.failedPost)
            } .resume()
            
        } catch {
            print("Error encoding album: \(error)")
            completion(.failedPost)
            return
        }
    }
    func createAlbum(artist: String, coverArt: [URL], name: String, genres: [String], id: String, songs: [Album.Song]) {
        
        let newAlbum = Album(artist: artist, coverArtURLs: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(newAlbum)
        putAlbums(album: newAlbum)
    }
    func createSong(duration: String, id: String = UUID().uuidString, title: String) -> Album.Song {
        
        let newSong = Album.Song(duration: duration, id: id, title: title)
        return newSong
        
    }
    func updateAlbum(album: Album, artist: String, covertArt: [URL], genres: [String], id: String, name: String, songs: [Album.Song]) {
        var updatedAlbum = album
        
        updatedAlbum.artist = artist
        updatedAlbum.coverArtURLs = covertArt
        updatedAlbum.genres = genres
        updatedAlbum.id = id
        updatedAlbum.name = name
        
        putAlbums(album: updatedAlbum)
    }
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("URL not functioning")
            return
        }
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            _ = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print("Got eem!")
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
            let albumData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: albumData)
            print(album)
            let encodedAlbum = try JSONEncoder().encode(album)
            print(String(data: encodedAlbum, encoding: .utf8)!)
            print("SUCCESS!")
        } catch {
            print("Error retrieving data: \(error)")
        }
    }

}
