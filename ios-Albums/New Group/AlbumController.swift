//
//  Album Controller.swift
//  ios-Albums
//
//  Created by Jerrick Warren on 11/27/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation
import UIKit

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    func testDecodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(string: path!)!)
            let decoded = try JSONDecoder().decode(Album.self, from: data)
            albums.append(decoded)
        } catch {
            fatalError("What is going on with this JSON??!")
        }
    }
    
    func testEncodingExampleAlbum() {
        let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(string: path!)!)
            let decoded = try JSONDecoder().decode(Album.self, from: data)
            albums.append(decoded)
        } catch {
            fatalError("What is going on with this JSON?!")
        }
    }
}
