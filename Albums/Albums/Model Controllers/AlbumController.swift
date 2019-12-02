//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let url = URL(string: "exampleAlbum.json")!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let _ = try jsonDecoder.decode(Album.self, from: data)
            } catch {
                print("Error Decoding")
                return
            }
        }.resume()
    }
}
