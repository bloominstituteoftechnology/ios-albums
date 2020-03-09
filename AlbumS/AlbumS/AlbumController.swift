//
//  AlbumController.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
class AlbumController {
    
    func testDecodingExampleAlbum() {
        let urlPath =  Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        do {
               let jsonData = try Data(contentsOf: urlPath)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
     
    }
    
}
