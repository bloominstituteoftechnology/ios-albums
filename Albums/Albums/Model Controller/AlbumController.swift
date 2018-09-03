//
//  AlbumController.swift
//  Albums
//
//  Created by Lisa Sampson on 9/2/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ; return }
        
        do {
            let exampleData = try Data(contentsOf: url)
            
            let album = try JSONDecoder().decode(Album.self, from: exampleData)
            
            print("Success!")
        }
        catch {
            print("Error getting data or decoding data: \(error)")
        }
    }
    
//    func textEncodingExampleAlbum() {
//        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad.") ; return }
//
//        do {
//            let exampleData = try Data(contentsOf: url)
//
//            let album = try JSONDecoder().decode(Album.self, from: exampleData)
//
//            _ = try JSONEncoder().encode(album)
//
//            print("Success!")
//        }
//        catch {
//            print("Error getting data or decoding data: \(error)")
//        }
//    }
}
