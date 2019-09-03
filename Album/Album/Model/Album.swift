//
//  Album.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArt: URL
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
        coverArt = try urlContainer.decode(URL.self, forKey: .url)
        
        //var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        
        genres = try container.decode([String].self, forKey: .genres)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        songs = try container.decode([Song].self, forKey: .songs)
    }
}
