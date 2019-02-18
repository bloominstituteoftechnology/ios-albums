//
//  AlbumController.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit

class AlbumController {
    
    
   func testDecodingExampleAlbum() {
        guard let jsonURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: ".json" ) else { return }
        let data = try! Data(contentsOf: jsonURL)

        let jsonDecoder = JSONDecoder()
    
        do {
            let decoded = try jsonDecoder.decode(Album.self, from: data)
            print(decoded)
        } catch {
            NSLog("\(error)")
            print("Error: \(error)")
        }
    }
}
