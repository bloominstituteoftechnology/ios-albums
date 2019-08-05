//
//  AlbumController.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        guard let testJSONURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        print(testJSONURL)
        let testAlbumData = try! Data(contentsOf: testJSONURL)
        let testAlbum = try! JSONDecoder().decode(Album.self, from: testAlbumData)
        print(testAlbum)
    }
}
