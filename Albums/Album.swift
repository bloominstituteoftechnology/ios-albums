//
//  Album.swift
//  Albums
//
//  Created by Lotanna Igwe-Odunze on 1/30/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

import Foundation

struct Album {
    
    var artist: String
    var coverArt: [URLS]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
}

struct URLS {
    var url: String
}
