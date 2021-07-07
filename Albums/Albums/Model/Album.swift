//
//  Album.swift
//  Albums
//
//  Created by Lisa Sampson on 8/31/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
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
