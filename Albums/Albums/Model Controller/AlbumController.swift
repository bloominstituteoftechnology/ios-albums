//
//  AlbumController.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class AlbumController {
    
    func testDecodingExampleAlbum() {
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        do {
            let testAlbum = try decoder.decode(Album.self, from: data)
            print("\(testAlbum)")
        } catch {
            NSLog("Error decoding test album: \(error)")
        }
    }
    
    
    // MARK: - Properties
    
    
    
}
