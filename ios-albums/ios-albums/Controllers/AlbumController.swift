//
//  AlbumController.swift
//  ios-albums
//
//  Created by Joseph Rogers on 3/9/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class AlbumController {
    
    func testDecodingExampleAlbum() -> Album? {
         if let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
             do {
                 let data = try Data(contentsOf: url)
                 let decoder = JSONDecoder()
                 let album = try decoder.decode(Album.self, from: data)
                 testEncodingExampleAlbum(data: album)
                 return album
             } catch {
                 print("Error decoding data: \(error.localizedDescription)")
             }
         }
         return nil
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
