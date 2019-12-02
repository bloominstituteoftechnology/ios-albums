//
//  AlbumController.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() throws -> Album {
        guard let exampleAlbumPath = Bundle.main.path(
            forResource: "exampleAlbum",
            ofType: "json")
            else {
                print("Error: no file at filepath!")
                throw NSError()
        }
        let exampleAlbumURL = URL(fileURLWithPath: exampleAlbumPath)
        
        let albumData = try Data(contentsOf: exampleAlbumURL)
        return try JSONDecoder().decode(Album.self, from: albumData)
    }
}
