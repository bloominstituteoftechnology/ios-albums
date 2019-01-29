//
//  AlbumController.swift
//  Albums
//
//  Created by Sergey Osipyan on 1/28/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import Foundation

class AlbumController {
    
    var temp: Album?
    
    func testDecodingExampleAlbum() -> Album {
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("URL is bad")
            fatalError()
        }
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print(album)
            temp = album
            
        } catch {
            
            print("error geting data \(error)")
        }
        return temp!
    }
    
    func testEncodingExampleAlbum() {
        
       
        do {
        
            let encodeAlbum = try JSONEncoder().encode(testDecodingExampleAlbum())
            print(String(data: encodeAlbum, encoding: .utf8)!)
        } catch {
            
             print("error encoding data \(error)")
        }
        
    }
}
