//
//  AlbumController.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
            
        do {
            let dataFromURL = try Data(contentsOf: urlPath)
            let decodedAlbum = try JSONDecoder().decode(Album.self, from: dataFromURL)
            //let decodedSongs: [Song] = try JSONDecoder().decode([Song].self, from: dataFromURL)
            print(decodedAlbum)
        } catch {
            print("Error decoding album objects: \(error)")
            return
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
            
        do {
            let dataFromURL = try Data(contentsOf: urlPath)
            let encodedAlbum = try JSONEncoder().encode(dataFromURL)
            //let decodedSongs: [Song] = try JSONDecoder().decode([Song].self, from: dataFromURL)
            print(encodedAlbum)
        } catch {
            print("Error encoding album objects: \(error)")
            return
        }
    }
}
