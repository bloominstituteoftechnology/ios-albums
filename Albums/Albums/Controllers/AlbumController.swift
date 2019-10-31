//
//  AlbumController.swift
//  Albums
//
//  Created by Vici Shaweddy on 10/30/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

class AlbumController {
    func testDecodingExampleAlbum() {
        if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Album.self, from: data)
                testEncodingExampleAlbum(data: jsonData)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
    
    func testEncodingExampleAlbum(data: Album) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(data)
            if let jsonDataAsString = String(data: jsonData, encoding: .utf8) {
                print(jsonDataAsString)
            }
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
}
