//
//  Album.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class Album : Decodable {
    var id: UUID
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var name: String
    var songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case id
        case artist
        case coverArt
        case genres
        case name
        case songs
    }
}
