//
//  AlbumController.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import Foundation

class AlbumController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noData
        case tryAgain
    }
    
    var albums: [Album] = []
    
    var baseURL = URL(string: "https://albums-b91db.firebaseio.com/")!
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            print("Error decoding data from example album: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
            
            let plistEncoder = PropertyListEncoder()
            plistEncoder.outputFormat = .xml
            do {
                let plistData = try plistEncoder.encode(album)
                let plistString = String(data: plistData, encoding: .utf8)!
                print(plistString)
            } catch {
                print("Error encoding data for example album: \(error)")
            }
            
        } catch {
            print("Error decoding data from example album: \(error)")
        }
    }
    
    func getAlbums(completion: @escaping (Result<[String: Album], NetworkError>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving album data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print(response)
                    completion(.failure(.tryAgain))
                    return
                }
            }
            guard let data = data else {
                print("No data received from getAlbums")
                completion(.failure(.noData))
                return
            }
            do {
                let albumArray = try JSONDecoder().decode([String: Album].self, from: data)
                for album in albumArray {
                    self.albums.append(album.value)
                }
                completion(.success(albumArray))
            } catch {
                print("Error decoding album data: \(error)")
                completion(.failure(.tryAgain))
            }
        }
        task.resume()
    }
    
    func put(album: Album, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let putURL = baseURL.appendingPathComponent("\(album.id).json")
        var request = URLRequest(url: putURL)
        request.httpMethod = HTTPMethod.put.rawValue
        do {
            let jsonData = try JSONEncoder().encode([album.id: album])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("Error saving album: \(error)")
                    completion(.failure(.tryAgain))
                    return
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        print(response)
                        completion(.failure(.tryAgain))
                        return
                    }
                }
                print("Album succesfully saved")
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding album: \(error)")
            completion(.failure(.tryAgain))
        }
    }
    
    func createAlbum(name: String, artist: String, id: String, genres: [String], coverArt: [String], songs: [Song]) {
        let album = Album(name: name, artist: artist, id: id, genres: genres, coverArt: coverArt, songs: songs)
        albums.append(album)
        put(album: album) { (result) in
            print("Result: \(result)")
        }
    }
    
    func createSong(title: String, duration: String) -> Song {
        return Song(title: title, duration: duration, id: UUID().uuidString)
    }
    
    func update(album: Album, name: String, artist: String, genres: [String], coverArt: [String], songs: [Song]) {
        var updatedAlbum = album
        updatedAlbum.name = name
        updatedAlbum.artist = artist
        updatedAlbum.genres = genres
        updatedAlbum.coverArt = coverArt
        updatedAlbum.songs = songs
        put(album: updatedAlbum) { (result) in
            print("Result: \(result)")
        }
    }
    
}
