//
//  AlbumController.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        
        do {
           let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            NSLog("Error decoding album")
        }
    }
    
    
    
    
    func testEncodingExampleAlbum() {
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        
       
        let album = try! decoder.decode(Album.self, from: data)
        print(album)
        
        
        let encoder = JSONEncoder()
        let albumData = try! encoder.encode(album)
        print(albumData)
        
        
    }
    
}
