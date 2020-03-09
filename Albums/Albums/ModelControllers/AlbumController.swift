//
//  AlbumController.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation


class AlbumController {
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        do {
            let data = try! Data(contentsOf: urlPath)
            let decoder = JSONDecoder()
            let json = try decoder.decode(Album.self, from: data)
            print(json)
        } catch {
            print(error)
        }
    }
}
