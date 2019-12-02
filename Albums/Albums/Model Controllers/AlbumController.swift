//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

private var persistentFileURL: URL? {
    guard let filePath = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return nil }
    return URL(fileURLWithPath: filePath)
}

class AlbumController {
    
    func testDecodingExampleAlbum() {
        
        guard let fileURL = persistentFileURL else { return }
        
        URLSession.shared.dataTask(with: fileURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let album = try jsonDecoder.decode(Album.self, from: data)
                print(album)
            } catch {
                print("Error Decoding")
                return
            }
            
        }.resume()
    }
    
    func testEncodingExampleAlbum() {
        
        guard let fileURL = persistentFileURL else { return }
        
        URLSession.shared.dataTask(with: fileURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = [.prettyPrinted]
            do {
                let album = try jsonDecoder.decode(Album.self, from: data)
                let encodedAlbum = try jsonEncoder.encode(album)
                let albumString = String(data: encodedAlbum, encoding: .utf8)!
                print(albumString)
            } catch {
                print("Error Encoding")
                return
            }
        }.resume()
    }
}

