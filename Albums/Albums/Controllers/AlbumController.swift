//
//  AlbumController.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() {
        do {
            let data = try Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))
            let json = try JSONDecoder().decode(Album.self, from: data)
            print("JSON: \(json)")
        } catch {
            print("Error: \(error)")
        }
    }
}
