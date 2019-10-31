//
//  AlbumController.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() -> Album? {
        var album: Album
        do {
            let data = try Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))
            album = try JSONDecoder().decode(Album.self, from: data)
            print("decoded JSON")
            return album
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
    
    func testEncodingExampleAlbum(_ album: Album) {
        do {
            let json = try JSONEncoder().encode(album)
            print("JSON: \(json)")
        } catch {
            print("Error: \(error)")
        }
    }
}
