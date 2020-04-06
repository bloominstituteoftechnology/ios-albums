//
//  AlbumController.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class AlbumController {
    
    // MARK: - Methods
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let codedData = try! Data(contentsOf: urlPath)
        
        let decoder = JSONDecoder()
        
        
        
        do {
            let data = try decoder.decode(Album.self, from: codedData)
            print(data)
        } catch {
            print(error)
        }
    }
    
    func testEncodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let codedData = try! Data(contentsOf: urlPath)
        
        let decoder = JSONDecoder()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try decoder.decode(Album.self, from: codedData)
            let encoded = try encoder.encode(data)
            let dataAsString = String(data: encoded, encoding: .utf8)!
            print(dataAsString)
        } catch {
            print(error)
        }
    }
}
