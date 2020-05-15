//
//  Album.swift
//  Albums
//
//  Created by Morgan Smith on 5/14/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import Foundation

struct Album: Decodable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Songs]
    
    
}
