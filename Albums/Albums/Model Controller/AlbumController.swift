//
//  AlbumController.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ;
            return
        }
        
        do {
            let exampleData = try Data(contentsOf: url)
            
            _ = try JSONDecoder().decode(Album.self, from: exampleData)
            
            print("Success!")
        }
        catch {
            print("Error getting data or decoding date: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ;
            return
        }
        
        do {
            let exampleData = try Data(contentsOf: url)
            
            let album = try JSONDecoder().decode(Album.self, from: exampleData)
            
            _ = try JSONEncoder().encode(album)
            
            print("Success!")
        }
        catch {
            print("Error getting data or decoding date: \(error)")
        }
        
    }
}
