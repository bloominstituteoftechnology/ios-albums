//
//  Album.swift
//  Albums
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

struct Album: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case id, artist, coverArt, genres, songs
        
        enum CoverKeys: String, CodingKey {
            case url
        }
    }
    
    var title: String
    var artist: String
    var id: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        genres = try genresContainer.decode([String].self)
        
        var coverArtContainer = try container.nestedContainer(keyedBy: CodingKeys.CoverKeys.self, forKey: .coverArt)
        coverArt = try coverArtContainer.decode([URL].self, forKey: .url)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: <#T##KeyedDecodingContainer<CodingKeys>.Key#>)
        
    }
}

struct Song: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case duration
        case id
    }
    
    var title: String
    var duration: String
    var id: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        duration = try container.decode(String.self, forKey: .duration)
        id = try container.decode(String.self, forKey: .id)
    }
}
