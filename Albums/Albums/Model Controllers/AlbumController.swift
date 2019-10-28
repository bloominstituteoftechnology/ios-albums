//
//  AlbumController.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!)
        
        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            NSLog("\(error)")
        }
    }
    
}
