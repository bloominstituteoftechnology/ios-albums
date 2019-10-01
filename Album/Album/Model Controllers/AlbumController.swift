//
//  AlbumController.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class AlbumController {
    static let shared = AlbumController()
    
    var albums: [Album] = []
    
    func testDecodingExampleAlbum() throws {
        let decoder = JSONDecoder()
        let URL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        if let URL = URL {
            do {
                let data = try Data(contentsOf: URL)
                print (String(describing:data))
                let album = try decoder.decode(Album.self, from: data)
                albums.append(album)
                print (String(describing: album))
            } catch {
                throw (error)
            }
        }
    }
    
    func testEncodingExampleAlbum() throws {
        let encoder = JSONEncoder()
        let URL = Bundle.main.url(forResource: "exampleAlbum2", withExtension: "json")
        if let URL = URL {
            do {
                let data = try encoder.encode(albums)
                try data.write(to: URL)
            } catch {
                throw (error)
            }
        
        }
    }
}
