//
//  Album.swift
//  AlbumList
//
//  Created by Bradley Diroff on 4/6/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
}

struct Song: Codable {
    
}
