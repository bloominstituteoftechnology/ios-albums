//
//  AlbumController.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch {
            print("Error decoding data from example album: \(error)")
        }
    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: urlPath)
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
            
            let plistEncoder = PropertyListEncoder()
            plistEncoder.outputFormat = .xml
            do {
                let plistData = try plistEncoder.encode(album)
                let plistString = String(data: plistData, encoding: .utf8)!
                print(plistString)
            } catch {
                print("Error encoding data for example album: \(error)")
            }
            
        } catch {
            print("Error decoding data from example album: \(error)")
        }
    }
    
}
