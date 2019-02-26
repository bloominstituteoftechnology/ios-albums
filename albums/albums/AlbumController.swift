//
//  AlbumController.swift
//  albums
//
//  Created by Lambda_School_Loaner_34 on 2/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print(album)
        } catch {
            print(error)
        }
    }
}

