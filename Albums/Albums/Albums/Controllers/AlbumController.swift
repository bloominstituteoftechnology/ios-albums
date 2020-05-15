//
//  AlbumController.swift
//  Albums
//
//  Created by David Williams on 5/14/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://albums-57758.firebaseio.com/")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        case noAuth
        case unauthorized
        case otherError(Error)
        case noData
        case decodeFailed
        case failedSignUp
        case failedSignIn
        case noToken
        case failPost
        case tryAgain
    }
    

    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "example", withExtension: "json") else { return }
        do {
            // This is essentially the same data that you would get back from an API
            let albumData = try Data(contentsOf: urlPath)
            let album = try JSONDecoder().decode(Album.self, from: albumData)
            print(album.name)
        } catch {
            NSLog("Error decoding test album: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "example", withExtension: "json") else { return }
        do {
            // This is essentially the same data that you would get back from an API
            let albumData = try Data(contentsOf: urlPath)
            let album = try JSONEncoder().encode(albumData)
            print(album)
        } catch {
            NSLog("Error encoding test album: \(error)")
            
        }
    }
    
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError(error)))
                }
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data returned from fetch")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let albums = try decoder.decode([String].self, from: data)
                completion(.success(true))
            } catch {
                print("Error decoding albums: \(error)")
                completion(.failure(.tryAgain))
                return
            }
        }
        task.resume()
    }
    
    func putAlbum(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        
    }
    

    func createAlbum(with name: String, artist: String, coverArtURLs: [URL], genres: String, songs: [Song]) {
        let album = Album(artist: artist, name: name, coverArt: coverArtURLs, genres: [genres])
    }
    
    
    func createSong(with name: String, artist: String, coverArtURLs: [URL], genres: String) -> Song {
        
        return
    }
    
    func update(album: Album, artist: String, genre: String, name: String, coverURLs: String) {
        
    }
    
    
}
