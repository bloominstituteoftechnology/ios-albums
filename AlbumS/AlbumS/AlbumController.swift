//
//  AlbumController.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
class AlbumController {
    
    
    var albums: [Album] = []
    let baseURL = URL(string: "https://album-840eb.firebaseio.com/")!
    
    func getAlbums(
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func testDecodingExampleAlbum() {
        let urlPath =  Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        do {
               let jsonData = try Data(contentsOf: urlPath)
            let jsonDecoder = JSONDecoder()
              let data = try  jsonDecoder.decode(Album.self, from: jsonData)
            print(data)
        } catch let err as NSError {
            print(err)
        }

    }

    func testEncodingExampleAlbum() {

        let urlPath =  Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
             do {
                let jsonData = try Data(contentsOf: urlPath)
                let jsonDecoder = JSONDecoder()
                let data = try  jsonDecoder.decode(Album.self, from: jsonData)
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                let newData = try  jsonEncoder.encode(data)
                let stringData = String(data: newData, encoding: .utf8)
                print(stringData!)
                
             }
             catch let err as NSError {
                 print(err.localizedDescription)
             }

    }

    
    
    
}
