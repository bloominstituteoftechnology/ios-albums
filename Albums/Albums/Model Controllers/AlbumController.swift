//
//  AlbumController.swift
//  Albums
//
//  Created by Ciara Beitel on 9/30/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            let data = try! Data(contentsOf: url)
            let album = try! JSONDecoder().decode(Album.self, from: data)
        } else {
            print("Error. Unable to parse json file.")
        }
    }
}
