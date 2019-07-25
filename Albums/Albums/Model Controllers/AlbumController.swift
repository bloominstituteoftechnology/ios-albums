//
//  AlbumController.swift
//  Albums
//
//  Created by Michael Stoffer on 7/24/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

let baseURL: URL = URL(string: "https://album-project-4a732.firebaseio.com/")!

class AlbumController {
    typealias CompletionHandler = (Error?) -> Void
    
    
    static func testDecodingExampleAlbum() {
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("\(album)")
        } catch {
            NSLog("Unable to decode test data: \(error)")
        }
    }
    
    static func testEncodingExampleAlbum() {
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: fileURL)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("\(album)")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let encodedAlbum = try encoder.encode(album)
            let albumString = String(data: encodedAlbum, encoding: .utf8)
            print(albumString!)
        } catch {
            NSLog("Unable to encode test data: \(error)")
        }
    }
}
