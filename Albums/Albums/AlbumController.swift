//
//  AlbumController.swift
//  Albums
//
//  Created by Kobe McKee on 6/10/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class AlbumController {
    
    
    
    
    func testDecodingExampleAlbum() {
        
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let json = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: json)
            print("\(album)")
        } catch {
            NSLog("Error loading test data: \(error)")
        }
    }
    
    
    
    func testEncodingExampleAlbum() {
        
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let json = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: json)
            
            let encodedAlbum = try JSONEncoder().encode(album)
            print("\(encodedAlbum)")
        } catch {
            NSLog("Error loading test data: \(error)")
        }
    }

    
    
}
