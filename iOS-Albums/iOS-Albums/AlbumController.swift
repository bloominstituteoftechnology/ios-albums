//
//  AlbumController.swift
//  iOS-Albums
//
//  Created by Lambda_School_Loaner_268 on 3/9/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    // MARK: - Methods
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        var data = try! Data(contentsOf: urlPath)
        
        
        
        var album = try! JSONDecoder().decode(Album.self, from: data)
        
        print(album)
    }
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        var data = try! Data(contentsOf: urlPath)
        
        
        
        var album = try! JSONEncoder().encode(data)
        
        print(album)
    }
}
