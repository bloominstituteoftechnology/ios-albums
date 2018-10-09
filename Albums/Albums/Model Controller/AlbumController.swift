//
//  AlbumController.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    var album: [Album] = []
    let baseURL = URL(string: "https://albums-3e830.firebaseio.com/")!
    typealias Completion = (Error?) -> Void
    
    // MARK: - Get
    
    func getAlbums(completion: @escaping Completion) {
        // Add path extension to the baseURL
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            // Check error
            // If error is not nil then log it
            if error != nil {
                NSLog("Error perfoeming data task")
                completion(error)
                return
            }
            
            // Check data
            // If data is nil then log it
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            // If data is not nil then decode it
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                // Key String, Value Album
                let albumDictionary = try decoder.decode([String:Album].self, from: data)
                let values = albumDictionary.map( { $0.value }) // Get values
                self.album = values
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
        
    }
    
    // MARK: - Put
    
    func put(album: Album, completion: @escaping Completion) {
        // Create a request URL
        // Add id's for unique loaction
        // Add extension path
        let url = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "PUT"
        
        // Encode the Album
        let encoder = JSONEncoder()
        
        do {
            let encodedAlbum = try encoder.encode(album)
            requestURL.httpBody = encodedAlbum
            completion(nil)
        } catch {
            NSLog("Error encoding Album:\(error)")
            completion(error)
            return
        }
        
        // Create a task
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if error != nil {
                NSLog("Error econding Album")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    // MARK: - Testing

    static func testDecodingExampleAlbum() -> Album? {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("Json file doesn't exist")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("Decoding successfull")
            return album
        } catch {
            NSLog("Couldn't decoded")
            return nil
        }
    }
    
    static func testEncodingExampleAlbum() {
        guard let album = testDecodingExampleAlbum() else {
            NSLog("Album is nil")
            return
        }
        
        do {
            let _ = try JSONEncoder().encode(album)
            print("Encoding successfull")
        } catch {
            NSLog("Error encoding album")
        }
    }
    
    
}
