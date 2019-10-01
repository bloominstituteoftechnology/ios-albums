//
//  AlbumController.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class AlbumController {
    static let shared = AlbumController()
    var albums: [Album] = []
    let baseURL: URL = URL(string: "https://albums-aff02.firebaseio.com/")!
    let albumControllerDebug: Bool = true
    
    @discardableResult func create(artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song] = []) -> Album {
        let myAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, name: name, songs: songs)
        albums.append(myAlbum)
        self.put(album: myAlbum) { (error) in
            if let error = error {
                NSLog("Error putting Album: \(error)")
            }
        }
        return myAlbum
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song] = []) {
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.name = name
        album.songs = songs
        self.put(album: album) { (error) in
            if let error = error {
                NSLog("Error putting Album in update: \(error)")
            }
        }
        return
    }
    
    func createSong(name: String, duration: TimeInterval) -> Song {
        return Song(duration: duration, name: name)
    }
    
    func testDecodingExampleAlbum() throws {
        let decoder = JSONDecoder()
        let URL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        if let URL = URL {
            do {
                let data = try Data(contentsOf: URL)
                //print (String(describing:data))
                let album = try decoder.decode(Album.self, from: data)
                albums.append(album)
                put(album: album) { (error) in
                    if let error = error {
                        NSLog("Error PUTing album: \(error)")
                    }
                }
                //print (String(describing: album))
            } catch {
                throw (error)
            }
        }
    }
    
    func testEncodingExampleAlbum() throws {
        let encoder = JSONEncoder()
        //let URL = Bundle.main.url(forResource: "exampleAlbum2", withExtension: "json")
        //if let URL = URL {
            do {
                let data = try encoder.encode(albums)
                print (String(describing: data))
            } catch {
                throw (error)
            }
        
        //}
    }
    
    //MARK: - Networking API
    
    func getAlbums (completion: @escaping (_ error: Error?) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print ("HTTP Response: \(response)")
                    completion(NetworkError.responseError)
                }
            }
            if let error = error {
                NSLog("Error fetching entries: \(error)")
                completion(NetworkError.responseError)
            }
            guard let data = data else {
                NSLog("No data returned from entries")
                completion(NetworkError.noData)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                self.albums = try decoder.decode([String: Album].self, from: data).map({ $0.value })
                if self.albumControllerDebug {print ("Albums: \(String(describing: self.albums))")}
                completion(nil)
            } catch {
                NSLog("Error decoding: \(error)")
                completion(NetworkError.noDecode)
            }
            }.resume()
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void) {
        let identifier = album.id.uuidString
        let requestURL = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(album)
            print ("HTTP Body: \(String(describing: request.httpBody))")
        } catch {
            NSLog("Error encoding task respresentation: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error PUTing album: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    
}
