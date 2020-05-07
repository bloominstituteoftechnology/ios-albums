//
//  AlbumController.swift
//  Albums
//
//  Created by Nonye on 5/7/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

class AlbumController {
    
    var album: Album?
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        if let data = try? Data(contentsOf: urlPath) {
            
            album = try? decoder.decode(Album.self, from: data)
            print("\(album)")
            testDecodingExampleAlbum()
            
        }
    }
    func testEncodingExampleAlbum() {
        let albumData = try! encoder.encode(album)
        let albumString = String(data: albumData, encoding: .utf8)!
        print("\(albumData)")
    }
}

