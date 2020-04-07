//
//  AlbumController.swift
//  AlbumList
//
//  Created by Bradley Diroff on 4/7/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: urlPath!)

        let decoder = JSONDecoder()
        
        let album = try! decoder.decode(Album.self, from: data)

        print("\(album)\n")
        
    }
}
