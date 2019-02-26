//
//  AlbumController.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        do {
            let album = try decoder.decode(Album.self, from: data)
            print("\(album)")
        } catch {
            NSLog("Error decoding album data: \(error)")
        }
        
        
    }
}
