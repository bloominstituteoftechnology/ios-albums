//
//  AlbumController.swift
//  Albums
//
//  Created by Kat Milton on 8/5/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    func testDecodingExampleAlbum() {
        guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let testAlbum = try decoder.decode(Album.self, from: data)
            albums.append(testAlbum)
            print(albums)
        } catch {
            NSLog("Error decoding: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: filePath)
            let decodedData = try JSONDecoder().decode(Album.self, from: data)
            let encodedData = try JSONEncoder().encode(decodedData)
            let albumString = String(data: encodedData, encoding: .utf8)!
            print(albumString)
        } catch {
            NSLog("Error encoding: \(error)")
        }
        
    }
}
