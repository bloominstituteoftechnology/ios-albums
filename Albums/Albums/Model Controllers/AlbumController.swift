//
//  AlbumController.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!)
        
        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            NSLog("\(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!)
        
        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let albumData = try encoder.encode(album)
            
            let dataAsString = String(data: albumData, encoding: .utf8)!
            print(dataAsString)
        } catch {
            NSLog("\(error)")
        }
    }
    
}
