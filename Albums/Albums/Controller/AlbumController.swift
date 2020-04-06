//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    var albums: [Album] = []
    let baseURL: URL = URL(string: "https://albums-39b0f.firebaseio.com/")!
    typealias CompletionHandler = (Error?) -> Void
    
    
    // MARK: - Coding
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned by dataTask")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let albumsData = try decoder.decode([String : Album].self, from: data)
            
                for album in albumsData {
                    self.albums.append(album.value)
                }
            } catch {
                NSLog("Error decoding or saving data from Firebase: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
//    func testDecodingExampleAlbum() {
//        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
//        let data = try! Data(contentsOf: urlPath)
//
//        let decoder = JSONDecoder()
//        let weezer = try! decoder.decode(Album.self, from: data)
//
//        print("\(weezer)")
//    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        
        let decoder = JSONDecoder()
        let weezer = try! decoder.decode(Album.self, from: data)
        
        print("\(weezer)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let weezerData = try! encoder.encode(weezer)
        
        let dataAsString = String(data: weezerData, encoding: .utf8)!
        print(dataAsString)
    }
}
