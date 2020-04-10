//
//  AlbumController.swift
//  Albums
//
//  Created by Harmony Radley on 4/9/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

import UIKit

class AlbumController {

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!

        if let data = try? Data(contentsOf: urlPath) {

            do {
                let result = try decoder.decode(Album.self, from: data)
                print(result)

            } catch {
                print(error)

            }
        }
    }
}
