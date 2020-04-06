//
//  AlbumController.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!

        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        
        let object = try! decoder.decode(Album.self, from: data)
        print(object)
    }
}
