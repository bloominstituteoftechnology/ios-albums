//
//  AlbumController.swift
//  Albums
//
//  Created by macbook on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    //TODO: Have it return an error, if there is one
    func testDecodingExampleAlbum() {
        
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let album = try! decoder.decode(Album.self, from: data)
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let albumData = try! encoder.encode(album)
        
        let dataAsString = String(data: albumData, encoding: .utf8)!
        print(dataAsString)
    }
    
}
