//
//  AlbumController.swift
//  Albums
//
//  Created by Dennis Rudolph on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print(album)
        } catch {
            print("Decoding Error")
        }
    }
    
    func testEncodingExampleAlbum() {
        let data = try! Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))

        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let albumData = try encoder.encode(album)

            let dataString = String(data: albumData, encoding: .utf8)!
            print(dataString)
        } catch {
            print("Encoding Error")
        }
    }
}

