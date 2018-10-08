//
//  AlbumController.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    static func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("Json file doesn't exist")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let _ = try JSONDecoder().decode(Album.self, from: data)
            print("Decoding successfull")
        } catch {
            NSLog("Couldn't decoded")
        }
    }
}
