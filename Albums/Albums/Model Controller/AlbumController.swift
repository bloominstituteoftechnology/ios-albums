//
//  AlbumController.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    static func testDecodingExampleAlbum() -> Album? {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("Json file doesn't exist")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("Decoding successfull")
            return album
        } catch {
            NSLog("Couldn't decoded")
            return nil
        }
    }
    
    static func testEncodingExampleAlbum() {
        guard let album = testDecodingExampleAlbum() else {
            NSLog("Album is nil")
            return
        }
        
        do {
            let _ = try JSONEncoder().encode(album)
            print("Encoding successfull")
        } catch {
            NSLog("Error encoding album")
        }
    }
}
