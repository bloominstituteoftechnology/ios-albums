//
//  Album.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

struct Album: Equatable {
    
    var albumCover: [String]
    var artist: String
    var albumName: String
    var genres: [String]
    var id: String
    var songs: [Song]
    
}

struct Song: Equatable {
    
    var id: String
    var duration: String
    var songName: String
    
}
