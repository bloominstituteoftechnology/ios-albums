//
//  AlbumController.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

class AlbumController {
    
    struct HTTPMethod {
        static let get = "GET"
        static let put = "PUT"
    }
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://albums-e99bf.firebaseio.com/")!
    
    
    func getAlbums(completion: @escaping (Error?) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("json")
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("no data returned")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decoded = try jsonDecoder.decode([String: Album].self, from: data).map { $0.value }
                self.albums = decoded
                completion(nil)
            } catch {
                print("unable to decode data into object of type [Album]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    
    
    func put(album: Album, completion: @escaping () -> Void = { }) {
        
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put
        
        do {
            let encoded = try JSONEncoder().encode(album)
            request.httpBody = encoded
        } catch {
            print(error)
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            
            if let error = error {
                print("Error PUT data: \(error)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    
    func createAlbum(id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let album = Album(id: id, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: songs)
        
        albums.append(album)
        put(album: album)
    }
    
    
    func createSong(id: String, name: String, duration: String) -> Song {
        return Song(title: name, duration: duration, id: id)
    }
    
    func update(album: Album, name: String, artist: String, genres: [String], songs: [Song], coverArt: [URL]) {
        
        //  not sure how to address
    }
    
    //  MARK: - codable testing
    func testDecodingExampleAlbum() {
        
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        do {
            let jsonData = try Data(contentsOf: urlPath)
            let result = try JSONDecoder().decode(Album.self, from: jsonData)
            print(result)
        } catch {
            print("error decoding data from JSON: \(error)")
            return
        }
        //  maybe use print statement here to check for success
    }
    
    func testEncodingExampleAlbum() {
        
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        var album: Album
        
        do {
            let jsonData = try Data(contentsOf: urlPath)
            album = try JSONDecoder().decode(Album.self, from: jsonData)
            print(album)
        } catch {
            print("error decoding data from JSON: \(error)")
            return
        }
        
        do {
            let results = try JSONEncoder().encode(album)
        } catch {
            print("error encoding album into JSON: \(error)")
            return
        }
    }
}
