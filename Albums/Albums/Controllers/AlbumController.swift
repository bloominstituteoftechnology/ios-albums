//
//  AlbumController.swift
//  Albums
//
//  Created by Nonye on 5/7/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class AlbumController {
    
    enum NetworkError: Error {
        //TODO:
    }
    //need a better naming system and understanding of what this is
    var albumOptional: Album?
    
    var albums: [Album] = []
    baseURL: URL
    
    func getAlbums(completion: @escaping (Error?) -> Void ) {
        
    }
    
    
    
    
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        if let data = try? Data(contentsOf: urlPath) {
            
            albumOptional = try? decoder.decode(Album.self, from: data)
            print("\(albumOptional)")
            testDecodingExampleAlbum()
            
        }
    }
    func testEncodingExampleAlbum() {
        let albumData = try! encoder.encode(albumOptional)
        let albumString = String(data: albumData, encoding: .utf8)!
        print("\(albumData)")
    }
}

