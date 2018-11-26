//
//  AlbumController.swift
//  ios-albums
//
//  Created by Nikita Thomas on 11/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    func testDecodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(string: path!)!)
            let decoded = try JSONDecoder().decode(Album.self, from: data)
            albums.append(decoded)
        } catch {
            fatalError("i hate this")
        }
    }
    
    func testEncodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(string: path!)!)
            let decoded = try JSONDecoder().decode(Album.self, from: data)
            albums.append(decoded)
        } catch {
            fatalError("i hate this")
        }
    }
}

