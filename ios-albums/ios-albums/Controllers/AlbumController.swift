//
//  AlbumController.swift
//  ios-albums
//
//  Created by TuneUp Shop  on 1/29/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

import Foundation

class AlbumController {
    
    static func testDecodingExampleAlbum() {
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: "/Users/strugglingfish/Developer/ios-albums/exampleAlbum.json"))
        let albumInfo = try! JSONDecoder().decode(Album.self, from: jsonData)
        print(albumInfo)
    }
}
