//
//  AlbumController.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    
        do {
            let data = try Data(contentsOf: urlPath)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: data)
            print(decodedAlbum)
        } catch {
            print("Error returned decoding album objects: \(error)")
            return
        }
        
    }
    
    func testEncodingExample() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"),
            let data = try? Data(contentsOf: urlPath) else { return }
        
//        let decoder = JSONDecoder()
//        let encoder = JSONEncoder()
        
        do {
            let album = try JSONDecoder().decode(Album.self, from: data)
            let albumData = try JSONEncoder().encode(album)
            print(String(data: albumData, encoding: .utf8)!)
        } catch let decodeError {
            print(decodeError)
        }
        
    }
    
}
