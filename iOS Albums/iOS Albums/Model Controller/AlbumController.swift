//
//  AlbumController.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class AlbumController {
    private var testJSONurl: URL? {
        return Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
    }
    
    func testDecodingExampleAlbum() {
        guard let url = testJSONurl else {
            NSLog("JSON file doesn't exist. Check your spelling.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: jsonData)
            print("Success! Decoded an album: \(decodedAlbum)")
        } catch {
            NSLog("Error decoding album: \(error)")
            return
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let url = testJSONurl else {
            NSLog("JSON file doesn't exist. Check your spelling.")
            return
        }
        
        var album: Album?
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: jsonData)
            print("Success! Decoded an album: \(decodedAlbum)")
            album = decodedAlbum
        } catch {
            NSLog("Error decoding album: \(error)")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let encodedAlbum = try JSONEncoder().encode(album)
            print("Success! Encoded an album{ \(encodedAlbum)")
        } catch {
            NSLog("Error encoding album: \(error)")
        }
    }
}
