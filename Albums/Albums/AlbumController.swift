//
//  AlbumController.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class AlbumController {
    
    let path = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    
    @discardableResult func testDecodingExampleAlbum() -> Album? {
    
        let decoder = JSONDecoder()
        do {
            let data = try! Data(contentsOf: path)
            return try decoder.decode(Album.self, from: data)
        } catch {
            print("There was an error decoding data")
            return nil
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let album = testDecodingExampleAlbum() else { return }
        
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(album)
            print(String(data: encodedData, encoding: .utf8))
        } catch {
            print("Error encoding data")
            return
        }
    }
}
