//
//  Album.swift
//  Albums
//
//  Created by David Williams on 5/14/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case name
        case identifier
        case coverArt
        case genres
        case songs
    }
    
    var artist: String
    var name: String
    var identifier: UUID
    var coverArt: [String]
    var genres: [String]
    var songs: [Song]
    
    func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(coverArt, forKey: .coverArt)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
       }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .artist)
        identifier = try container.decode(UUID.self, forKey: .identifier)
        coverArt = try container.decode([String].self, forKey: .coverArt)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
    }
}

struct Song: Codable {

enum SongKeys: String, CodingKey {
    case duration
    case id
    case name
}
    
    let name: String
    let id: String
    let duration: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        name = try container.decode(String.self, forKey: .name)
        duration = try container.decode(String.self, forKey: .duration)
        id = try container.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(duration, forKey: .duration)
    }
}
