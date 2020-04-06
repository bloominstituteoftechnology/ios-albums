//
//  AlbumController.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")

        /*
         
        - Get the JSON data from the "exampleAlbum.json" file. (Data(contentsOf: URL))
        - Try to decode the JSON using JSONDecoder just like you would if you got this data from an API.
        - Check for errors. This is important because it will help you make sure you've correctly implemented the init(from decoder: Decoder) throws initializer in your model objects by giving you an error about what you have potentially done wrong.

         */
        
    }
}
