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
        
        enum AlbumCoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        var coverArtStrings: [String] = []
        let coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtContainer.isAtEnd {
            let coverArtString = try coverArtContainer.decode(String.self)
        }
    }
}
