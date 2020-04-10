//
//  AlbumController.swift
//  Albums
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation
class AlbumController {

    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("Error: Could not locate JSON file in App bundle.")
            return
        }

        do {
            let jsonData = try Data(contentsOf: urlPath)
            let _ = try JSONDecoder().decode(Album.self, from: jsonData)
        } catch {
            print("Error decoding data from JSON file: \(error).")
            return
        }

        print("Successfully decoded data from JSON file!")
    }

    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("Error: Could not locate JSON file in App bundle.")
            return
        }

        let album: Album

        do {
            let jsonData = try Data(contentsOf: urlPath)
            album = try JSONDecoder().decode(Album.self, from: jsonData)
        } catch {
            print("Error decoding data from JSON file: \(error).")
            return
        }

        do {
            let _ = try JSONEncoder().encode(album)
        } catch {
            print("Error encoding album back into JSON: \(error).")
            return
        }

        print("Successfully encoded data back into JSON!")

    }
}
