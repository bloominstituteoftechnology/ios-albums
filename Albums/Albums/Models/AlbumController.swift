//
//  AlbumController.swift
//  Albums
//
//  Created by Bobby Keffury on 10/30/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    private let baseURL = URL(string: "https://albums-f4f46.firebaseio.com/")!

    
    func testDecodingExampleAlbum() {
        
        let decoder = JSONDecoder()
        
        if let pathString = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {

            do {
                let fileURL = URL(fileURLWithPath: pathString)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let album = try decoder.decode(Album.self, from: data)
                self.albums.append(album)
                
            } catch {
                print("Error Decoding Album: \(error)")
            }
            
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let encoder = JSONEncoder()
        
        if let pathString = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") {

            do {
                let fileURL = URL(fileURLWithPath: pathString)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
//                let album = try encoder.encode(Album.self)
               
            } catch {
                print("Error Encoding Album: \(error)")
            }
            
        }
    }

}
