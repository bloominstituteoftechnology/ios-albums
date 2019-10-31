//
//  AlbumController.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

class AlbumController {
    
    static let shared = AlbumController()
    
    func testDecodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        do {
            let decoder = JSONDecoder()
            let testAlbum = try decoder.decode(Album.self, from: data)
            print(testAlbum)
        } catch {
            print("Error decoding")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        do {
            let decoder = JSONDecoder()
            let testAlbum = try! decoder.decode(Album.self, from: data)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let album = try encoder.encode(testAlbum)
            
            let stringData = String(data: album, encoding: .utf8)!
            print(stringData)
        } catch {
            print("Error encoding")
        }
        
    }
    
}
