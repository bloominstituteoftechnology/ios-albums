//
//  AlbumController.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let _ = try JSONDecoder().decode(Album.self, from: data)
            } catch {
                print("Error. Unable to decode json file.")
            }
        } else {
            print("Error. Unable to find json file.")
        }
    }
    
    func testEncodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let album = try JSONDecoder().decode(Album.self, from: data)
                let _ = try JSONEncoder().encode(album)
            } catch {
                print("Error. Unable to encode json file.")
            }
        } else {
            print("Error. Unable to find json file.")
        }
    }
}

