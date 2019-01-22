//
//  AlbumController.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import Foundation

class AlbumController {
    
    static func testDecodingExampleAlbum(){
        // get the JSON Data from the 'exampleAlbum.json' file.
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        var exampleAlbum: Album
        do {
            exampleAlbum = try decoder.decode(Album.self, from: data)
            
        } catch {
            NSLog("Error decoding JSON data: \(error)")
            return
        }
        
        let album = exampleAlbum
        
        
    }

    static func testEncodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        var exampleAlbum: Album
        do {
            exampleAlbum = try decoder.decode(Album.self, from: data)
            
        } catch {
            NSLog("Error decoding JSON data: \(error)")
            return
        }
       
        let album = exampleAlbum
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        let albumData = try! encoder.encode(album)
        
        print(String(data: albumData, encoding: .utf8)!)
        
        
        
        
        let decoder2 = JSONDecoder()
        var exampleAlbum2: Album
        do {
            exampleAlbum2 = try decoder2.decode(Album.self, from: albumData)
            
        } catch {
            NSLog("Error decoding JSON data: \(error)")
            return
        }
    }
}
