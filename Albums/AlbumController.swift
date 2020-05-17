//
//  AlbumController.swift
//  Albums
//
//  Created by Kenneth Jones on 5/17/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            // This is essentially the same data that you would get back from an API
            let albumData = try Data(contentsOf: urlPath)
            let album = try JSONDecoder().decode(Album.self, from: albumData)
            print(album.name)
        } catch {
            NSLog("Error decoding test album: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            let albumData = try Data(contentsOf: urlPath)
            let album = try JSONDecoder().decode(Album.self, from: albumData)
            print(album.name)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let newAlbumData = try encoder.encode(album)
            let albumString = String(data: newAlbumData, encoding: .utf8)
            print(albumString!)
        } catch {
            NSLog("Error coding test album: \(error)")
        }
    }
}
