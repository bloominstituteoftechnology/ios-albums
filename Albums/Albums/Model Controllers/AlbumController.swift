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
        
        let decoder = JSONDecoder()
        let test = try! decoder.decode(Album.self, from: data)
        print(test)
    }
    
}
