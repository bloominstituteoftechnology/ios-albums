//
//  AlbumController.swift
//  iOS Albums
//
//  Created by Dillon P on 10/30/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation

class AlbumController {
    
    static var shared = AlbumController()
    
    func testDecodingExampleAlbum() {
        
        if let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let album = try decoder.decode(Album.self, from: data)
                print(album)
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }
    
    func testEncodingExampleAlbum() {
        
        if let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let album = try decoder.decode(Album.self, from: data)
                
                let encoder = JSONEncoder()
                let encodedAlbum = try encoder.encode(album)
                print(encodedAlbum)
            } catch {
                print("Error Encoding data: \(error)")
            }
        }
    }
    
}
