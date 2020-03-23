//
//  Album.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    var artist: String
    var coverArt: String
    var genres: String
    var id: UUID?
    var name: String
    
    init(artist: String, coverArt: String, genres: String, id: UUID = UUID(), name: String) {
        
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        let coverArtContainer = try container.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self, forKey: .coverArt)
        coverArt = try coverArtContainer.decode(String.self, forKey: .url)
        
        genres = try container.decode(String.self, forKey: .genres)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtContainer = container.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self, forKey: .coverArt)
        try coverArtContainer.encode(coverArt, forKey: .url)
        
        try container.encode(genres, forKey: .genres)
        
        try container.encode(id, forKey: .id)
        
        try container.encode(name, forKey: .name)

    }
}
