//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_218 on 1/13/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"), let data = try? Data(contentsOf: url) else { return }
        
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch let decodeError {
            print(decodeError)
        }
    }
}
