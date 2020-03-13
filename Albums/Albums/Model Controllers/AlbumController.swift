//
//  AlbumController.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    private let baseURL = URL(string: "https://lambdaalbumscodableproject.firebaseio.com/")
    
    func getAlbums(completion: @escaping (Error?) -> Void = { _ in }) {
        guard let baseURL = baseURL else { return }
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _,  error in
            guard error == nil else {
                print("Error getting albums from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(NSError())
                return
            }
            
            do {
                
            } catch {
                
            }
        }
        
    }
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
            
        do {
            let dataFromURL = try Data(contentsOf: urlPath)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: dataFromURL)
            //let decodedSongs: [Song] = try JSONDecoder().decode([Song].self, from: dataFromURL)
            print(decodedAlbum)
        } catch {
            print("Error decoding album objects: \(error)")
            return
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
            
        do {
            let dataFromURL = try Data(contentsOf: urlPath)
            let encodedAlbum = try JSONEncoder().encode(dataFromURL)
            let stringAlbum = String(data: encodedAlbum, encoding: .utf8)
            print(stringAlbum)
        } catch {
            print("Error encoding album objects: \(error)")
            return
        }
    }
}
