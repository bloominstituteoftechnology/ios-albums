//
//  AlbumController.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class AlbumController {

    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return}
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let album = try! decoder.decode(Album.self, from: data)
        print(album)

    }


}
