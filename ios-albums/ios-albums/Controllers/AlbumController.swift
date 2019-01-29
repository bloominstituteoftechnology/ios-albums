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
        print("Album decoded: \(albumInfo)")
    }
    
    static func testEncodingExampleAlbum() {
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: "/Users/strugglingfish/Developer/ios-albums/exampleAlbum.json"))
        let albumInfo = try! JSONDecoder().decode(Album.self, from: jsonData)
        //print(albumInfo)
        let encodedAlbum = try! JSONEncoder().encode(albumInfo)
        print("Album encoded: \(encodedAlbum)")
    }
}
