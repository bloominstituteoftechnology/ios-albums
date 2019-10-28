//
//  AlbumController.swift
//  Albums
//
//  Created by Gi Pyo Kim on 10/28/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
        } catch {
            NSLog("Error decoding album: \(error)")
        }
    }
    
}
