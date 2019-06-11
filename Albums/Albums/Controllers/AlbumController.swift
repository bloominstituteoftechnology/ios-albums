//
//  AlbumController.swift
//  Albums
//
//  Created by Sameera Roussi on 6/11/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import Foundation

class AlbumController {
    
    // Set
    
    func testDecodingExampleAlbum() {
        
        // Point to this app bundle
        let mainBundle = Bundle.main
        // Ask the bundle for the URL of the exampleAlbum.json file
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")! // <- We are force unwrapping HERE ONLY!
        do  {
            let json = try Data(contentsOf: fileURL )
            let album = try JSONDecoder().decode(Album.self, from: json)
            // Just a print to make sure it's correct
            NSLog("\(album)")
        } catch {
            NSLog("Did you import the exampleAlbum file? \(error)")
            return
        }
    }
}
