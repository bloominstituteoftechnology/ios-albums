//
//  Album.swift
//  Albums
//
//  Created by Sameera Roussi on 6/11/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let id: String
    let name: String
    
//    let coverArt: String
//    let genres: String
//    let songs: [Song]
//
    enum SongKeys: String, CodingKey {
        case artist
        case id
        case name
  //      case cover
    }
    
    // init
    init(from decoder: Decoder) throws {
        // Create the song container
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        // Decode artist
        artist = try container.decode(String.self, forKey: .artist)
        
        // Decode id
        id = try container.decode(String.self, forKey: .id)
        
        //Decode name (of the album)
        name = try container.decode(String.self, forKey: .name)
        
        // Decode the cover art
  //      let coverArtString = try container.decode([])
    }
    
}
