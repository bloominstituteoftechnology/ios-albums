//
//  AlbumController.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class AlbumController {
    
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    func testDecodingExampleAlbum() {
        
        guard let fileUrl = persistentFileURL else { return }
        URLSession.shared.dataTask(with: fileUrl) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let testAlbum = try jsonDecoder.decode(Album.self, from: data)
//                print(testAlbum)
            } catch {
                print("error decoding album: \(error)")
                return
            }
        }.resume()
    }
    
    func testEncodingExampleAlbum() {
        guard let fileUrl = persistentFileURL else { return }
        URLSession.shared.dataTask(with: fileUrl) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = [.prettyPrinted]
            do {
                let decodedTestAlbum = try jsonDecoder.decode(Album.self, from: data)
                print("decoded:", decodedTestAlbum)
                let encodedTestAlbum = try jsonEncoder.encode(decodedTestAlbum)
                print("encoded:", encodedTestAlbum)
                let encodedTestAlbumString = String(data: encodedTestAlbum, encoding: .utf8)!
                print("json:", encodedTestAlbumString)
            } catch {
                print("error decoding album: \(error)")
                return
            }
        }.resume()
    }
}
