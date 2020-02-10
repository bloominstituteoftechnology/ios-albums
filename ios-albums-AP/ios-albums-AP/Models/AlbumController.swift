//
//  AlbumController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

// Data(contentsOf: "exampleAlbum.json")
class AlbumController {
    
    /*
     // !!! THIS IS BAD WAY TO DO IT DON"T DO IN YOUR APPS
     let url = URL(string: "https://swapi.co/api/people/1/")!
     let data = try! Data(contentsOf: url)

     let decoder = JSONDecoder()
     let luke = try! decoder.decode(Person.self, from: data)

     print(luke)

     let encoder = JSONEncoder()
     encoder.outputFormatting = [.prettyPrinted]
     let lukeData = try! encoder.encode(luke)

     let lukeString = String(data: lukeData, encoding: .utf8)
     print(lukeString!)
     */
    
    func testDecodingExampleAlbum() {
        print("TEST DECODING CALLED")
        
        let url = URL(string: "exampleAlbum.json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let exampleAlbum = try! decoder.decode(Album.self, from: data)
        print(exampleAlbum)
    }
    
    func testEncodingExampleAlbum() {
        print("TEST ENCODING CALLED")
    }
}
