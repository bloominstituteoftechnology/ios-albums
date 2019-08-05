//
//  AlbumController.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

class AlbumController {
    
    enum NetworkError: Error {
        case otherError
        case badData
        case noDecode
        case noEncode
        case badResponse
        case badAuth
        case noAuth
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum AlbumMethod: String {
        case create
        case update
    }
    
    var albums: [Album] = []
    let baseURL: URL = URL(string: "https://journal-9006c.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (NetworkError?) -> Void) {
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.otherError)
                return
            }
            
            guard let data = data else {
                completion(.badData)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let albumsDict = try jsonDecoder.decode([String: Album].self, from: data)
                self.albums = Array(albumsDict.values)
                completion(nil)
            } catch {
                print("\(error)")
                completion(.noDecode)
                print("decode failure")
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping () -> Void = { }) {
        let uuid = album.id
        let requestURL = baseURL.appendingPathComponent(uuid).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album \(album): \(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTting album to server: \(error)")
                completion()
                return
            }
            
            completion()
        }.resume()
    }
    
    func createUpdateAlbum(album: Album?, title: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let newAlbum: Album
        
        if let album = album {
            newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: album.id, albumTitle: title, songs: songs)
        } else {
            newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: UUID().uuidString, albumTitle: title, songs: songs)
        }
        
        put(album: newAlbum)
    }
    
    func createSong(title: String, duration: String) -> Song {
        let song = Song(duration: duration, id: UUID().uuidString, name: title)
        return song
    }
    
    func testDecodingExampleAlbum() {
        guard let testJSONURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        print(testJSONURL)
        let testAlbumData = try! Data(contentsOf: testJSONURL)
        let testAlbum = try! JSONDecoder().decode(Album.self, from: testAlbumData)
        print(testAlbum)
    }
}
