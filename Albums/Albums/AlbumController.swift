//
//  AlbumController.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

class AlbumController {
    
    static func testDecodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let album = try! JSONDecoder().decode(Album.self, from: data)
        print(album)
    }
}
