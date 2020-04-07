//
//  AlbumController.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post   = "POST"   // Create
    case get    = "GET"    // Read
    case put    = "PUT"    // Update/Replace
    case patch  = "PATCH"  // Update/Replace
    case delete = "DELETE" // Delete
}

class AlbumController {
    
    // MARK: - Properites
    typealias CompletionHandler = (Error?) -> Void

    var albums: [Album] = []
    
    // Firebase
    let firebaseBaseURL = URL(string: "https://albums-lambda-gerrior.firebaseio.com/")!
    
    // MARK: - CRUD
    
    // Create
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        let uuid = album.id.uuidString == "" ? UUID() : album.id
        let requestURL = firebaseBaseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue

        do {
// FIXME:            album.id = uuid // TODO: ? What if it didn't change?
            request.httpBody = try JSONEncoder().encode(album)

        } catch {
            NSLog("Error encoding/saving album: \(error)")
            completion(error)
        }

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error PUTing album to server \(error)")
                completion(error)
                return
            }

            completion(nil)
        }.resume()
    }

    // Read

    // searchForMovie
    func getAlbums(completion: @escaping (Error?) -> Void) {
        
        let requestURL = firebaseBaseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            /// Did the call complete without error?
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            /// Did we get anything?
            guard let data = data else {
                NSLog("No data returned by data task")
                completion(NSError()) // Convert to ResultType
                return
            }
            
            /// Unwrap the data returned in the closure.
            do {
                let anAlbum = try JSONDecoder().decode([String: Album].self,
                                                                     from: data).values
                
                self.albums.append(contentsOf: anAlbum)
//                try self.updateMovies(with: albumRepresentation)
                completion(nil)
                
            } catch {
                NSLog("Error decoding or saving data from Firebase: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    // Update
    
    // Delete
    
    // MARK: - Functions
    
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        let data = try! Data(contentsOf: urlPath)

        let decoder = JSONDecoder()

        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        albums = [try! decoder.decode(Album.self, from: data)]

        print("\(albums)\n")
        
        put(album: albums[0])
        getAlbums() { _ in print("read albums")}
    }
    
    func testEncodingExampleAlbum() {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        encoder.outputFormatting = .prettyPrinted
        
        let data = try! encoder.encode(albums)

        let dataAsString = String(data: data, encoding: .utf8)!
        print(dataAsString)
    }
}
