//
//  AlbumController.swift
//  Albums
//
//  Created by Ivan Caldwell on 1/28/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum(){
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("\nAlbumController.swift\nError: Bad URL - Line 16\n")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print(album)
        } catch {
            print("\nAlbumController.swift\nError retrieving data: \(error)\n")
        }
    }
}
