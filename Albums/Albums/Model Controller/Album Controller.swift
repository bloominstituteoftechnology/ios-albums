//
//  Album Controller.swift
//  Albums
//
//  Created by Jonalynn Masters on 10/28/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation

class AlbumController {
    var albums: [Album] = []
    var songs: [Songs] = []
    
// MARK: Test Decoding Example Album
    func testDecodingExampleAlbum() {
        
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let json = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: json)
            print("\(album)")
        } catch {
            NSLog("Error loading test data: \(error)")
        }
    }
}
