//
//  AlbumController.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properites
    var album: Album?
    
    // MARK: - Functions
    
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        let data = try! Data(contentsOf: urlPath)

        let decoder = JSONDecoder()

        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        album = try! decoder.decode(Album.self, from: data)

        print("\(album!)\n")
    }
    
    func testEncodingExampleAlbum() {
        
        guard let album = album else { return }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        encoder.outputFormatting = .prettyPrinted
        
        let data = try! encoder.encode(album)

        let dataAsString = String(data: data, encoding: .utf8)!
        print(dataAsString)
    }
}
