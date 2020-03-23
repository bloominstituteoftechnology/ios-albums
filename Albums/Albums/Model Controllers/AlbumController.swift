//
//  AlbumController.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkingError: Error {
    case noData
    case noBearer
    case serverError(Error)
    case unexpectedStatusCode
    case badDecode
    case badEncode
    case fetchingError
    case putError
}

class AlbumController {
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://albums-3c500.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (NetworkingError?) -> Void = { _ in }) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(.fetchingError)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from album fetch data task")
                completion(.noData)
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([String: Album].self, from: data).map({ $0.value })
                completion(nil)
            } catch {
                NSLog("Error decoding albums: \(error)")
            }
            completion(.badDecode)
        }.resume()
    }
    
    func put(album: Album, completion: @escaping () -> Void = { }) {
        
        var album = album
        
        let identifier = album.id ?? UUID()
        album.id = identifier
        
        let requestURL = baseURL
            .appendingPathComponent(identifier.uuidString)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            
            if let error = error {
                NSLog("Error PUTing album: \(error)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    func createAlbum(with artist: String, coverArt: String, genres: String, name: String) {
        
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, name: name)
        albums.append(album)
        put(album: album)
    }
    
    func createSong(with duration: String, name: String) -> Songs{
        let song = Songs(duration: duration, name: name)
        return song
    }
    
    func updateAlbum(album: Album, artist: String, coverArt: String, genres: String, name: String) {
        
        put(album: album)
    }
}
