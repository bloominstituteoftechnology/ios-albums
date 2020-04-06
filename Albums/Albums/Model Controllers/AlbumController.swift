//
//  AlbumController.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class AlbumController {
    
    var object: Album?
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!

        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        
        object = try! decoder.decode(Album.self, from: data)
        print("\(object!) \n")
        testEncodingExampleAlbum()
    }
    
    func testEncodingExampleAlbum() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let albumData = try! encoder.encode(object)
        let albumDataAsString = String(data: albumData, encoding: .utf8)!
        print(albumDataAsString)
    }
}
