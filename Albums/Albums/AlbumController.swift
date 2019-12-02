//
//  AlbumController.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class AlbumController {
    var albums: [Album] = []
    
    let baseURL: URL = URL(string: "https://lambda-ios-testbed.firebaseio.com/")!
    
    func getAlbums(completion: @escaping (Result<[Album],Error>) -> ()) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Album fetching failed with response:\n\(response?.description ?? "???")")
                completion(.failure(error ?? NSError()))
                return
            }
            do {
                let albumsDict = try JSONDecoder().decode([String:Album].self, from: data)
                self.albums = albumsDict.map { (_, album) -> Album in
                    return album
                }
                completion(.success(self.albums))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func put(album: Album) {
        let url = baseURL
            .appendingPathComponent(album.id)
            .appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Album upload failed with error: \(error)")
                print("Response:\n\(response?.description ?? "???")")
                if let data = data {
                    print(String(data: data, encoding: .utf8) ?? "")
                }
            }
        }.resume()
    }
    
    func createAlbum(withName name: String, artist: String, genres: [String], songs: [Song], coverArtURLs: [URL]) {
        let album = Album(name: name, artist: artist, genres: genres, songs: songs, coverArtURLs: coverArtURLs)
        albums.append(album)
        put(album: album)
    }
    // MARK: - Test Data Methods
    func testDecodingExampleAlbum() throws -> Album {
        guard let exampleAlbumPath = Bundle.main.path(
            forResource: "exampleAlbum",
            ofType: "json")
            else {
                print("Error: no file at filepath!")
                throw NSError()
        }
        let exampleAlbumURL = URL(fileURLWithPath: exampleAlbumPath)
        
        let albumData = try Data(contentsOf: exampleAlbumURL)
        return try JSONDecoder().decode(Album.self, from: albumData)
    }
    
    func testEncodingExampleAlbum(_ album: Album) throws -> Data {
        return try JSONEncoder().encode(album)
    }
}
