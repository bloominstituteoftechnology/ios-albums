//
//  Album.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    var artist: String
    var coverArt: [String]
    var genres: [String]
    var songs: [Song]
    var id: String
    var name: String
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case songs
        case id
        case name
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    // DECODING
    init(from decoder: Decoder) throws {
        
    }
}

