//
//  AlbumExtension.swift
//  Albums
//
//  Created by Paul Yi on 2/26/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

extension Album: Codable {
    
    enum CodingKeys: String, CodingKey {
        case albumCover = "coverArt"
        case artist
        case albumName = "name"
        case genres
        case id
        case songs
        
        enum CoverCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        
        let albumName = try container.decode(String.self, forKey: .albumName)
        
        let genres = try container.decode([String].self, forKey: .genres)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let songs = try container.decode([Song].self, forKey: .songs)
        
        var albumCoverContainer = try container.nestedUnkeyedContainer(forKey: .albumCover)
        
        var albumCover: [String] = []
        
        while !albumCoverContainer.isAtEnd {
            
            let coverContainer = try albumCoverContainer.nestedContainer(keyedBy: CodingKeys.CoverCodingKeys.self)
            
            let covers = try coverContainer.decode(String.self, forKey: .url)
            
            albumCover.append(covers)
        }
        
        self.albumCover = albumCover
        self.artist = artist
        self.albumName = albumName
        self.genres = genres
        self.id = id
        self.songs = songs
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        try container.encode(albumName, forKey: .albumName)
        
        try container.encode(genres, forKey: .genres)
        
        try container.encode(id, forKey: .id)
        
        try container.encode(songs, forKey: .songs)
        
        var albumCoverContainer = container.nestedUnkeyedContainer(forKey: .albumCover)
        for cover in albumCover {
            
            var coverContainer = albumCoverContainer.nestedContainer(keyedBy: CodingKeys.CoverCodingKeys.self)
            
            try coverContainer.encode(cover, forKey: .url)
        }
    }
}
