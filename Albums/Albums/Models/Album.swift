//
//  Album.swift
//  Albums
//
//  Created by Dahna on 4/9/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArt: [CoverArt]
    let genres: [String]
    let id, name: String
    let songs: [Song]
}

struct CoverArt: Codable {
    let url: String
}

struct Song: Decodable {
    let duration: String
    let id: String
    let name: String
    
    private enum SongCodingKeys: String, CodingKey {
        case id
        case duration
        case name
        
        enum DurationCodingKeys: String, CodingKey {
            case timeLength = "duration"
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    init(decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: SongCodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        
        var durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .timeLength)
        
        var nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
    }
}

struct Duration: Decodable {
    let duration: String
}

struct Name: Decodable {
    let title: String
}
