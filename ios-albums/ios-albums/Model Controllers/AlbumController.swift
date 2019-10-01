//
//  AlbumController.swift
//  ios-albums
//
//  Created by Alex Shillingford on 9/30/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

class AlbumController {
    
    static let shared = AlbumController()
    
    func testDecodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        let data = try! Data(contentsOf: url)
        
        let album = try! JSONDecoder().decode(Album.self, from: data)
        
        print(album)
    }
    
    func testEncodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        let data = try! Data(contentsOf: url)
        
        let album = try! JSONDecoder().decode(Album.self, from: data)
        
        do {
            try JSONEncoder().encode(album)
            print("SUCCESS ENCODING ALBUM")
        } catch {
            NSLog("Error encoding Album struct: \(error)")
        }
    }
    
}
