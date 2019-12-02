//
//  Album.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Album: Decodable {
    var id: String
    var name: String
    var artist: String
    var genres: [String]
    var coverArtURLs: [URL]
    var songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case genres
        case coverArt
        case songs
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        
        coverArtURLs = []
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtContainer.isAtEnd {
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtKey.self)
            let coverArtURLString = try coverArtURLContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: coverArtURLString) {
                coverArtURLs.append(coverArtURL)
            }
        }
        
        songs = try container.decode([Song].self, forKey: .songs)
    }
}
