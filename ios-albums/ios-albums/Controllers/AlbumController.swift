//
//  AlbumController.swift
//  ios-albums
//
//  Created by TuneUp Shop  on 1/29/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

import Foundation

class AlbumController {
    
    init() {
        getAlbums()
    }
    
    typealias CompletionHandler = (Error?) -> Void
    var albums: [Album] = []
    
    private let baseURL = URL(string: "")!
    
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) {(data, _, error) in
            
            if let error = error {
                print("error fetching entry: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("no data returned")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([String: Album].self, from: data)
                self.albums = Array(decodedResponse.values)
                
                completion(nil)
                
            }catch {
                print("error importing entries: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }){
        let id = album.id
        let requestURL = baseURL.appendingPathComponent(id).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            
            request.httpBody = try JSONEncoder().encode(album)
            
        }catch {
            print("error saving task: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("error putting task: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            return
            }.resume()
        
    }
    
    func createAlbum(artist: String, coverArt: URL, genres: [String], id: String = UUID().uuidString, name: String, songs: [Song]){
        
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        
        self.put(album: newAlbum)
    }
    
    func createSong(duration: String, id: String, name: String) -> Song {
        
        return Song(duration: duration, id: id, name: name)
    }
    
    func update(album: Album, artist: String, coverArt: URL, genres: String, id: String, name: String, songs: [Song]) {
        var updatedAlbum = album
        updatedAlbum.artist = artist
        
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Testing
    static func testDecodingExampleAlbum() {
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: "/Users/strugglingfish/Developer/ios-albums/exampleAlbum.json"))
        let albumInfo = try! JSONDecoder().decode(Album.self, from: jsonData)
        print("Album decoded: \(albumInfo)")
    }
    
    static func testEncodingExampleAlbum() {
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: "/Users/strugglingfish/Developer/ios-albums/exampleAlbum.json"))
        let albumInfo = try! JSONDecoder().decode(Album.self, from: jsonData)
        //print(albumInfo)
        let encodedAlbum = try! JSONEncoder().encode(albumInfo)
        print("Album encoded: \(encodedAlbum)")
    }
}
