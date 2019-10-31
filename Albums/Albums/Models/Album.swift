//
//  Album.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

struct Album: Codable {
    let id: String
    let name: String
    let artist: String
    let coverArt: [String]
    let genres: [String]
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case coverArt
        case genres
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var covers = [String]()
        var coversContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coversContainer.isAtEnd {
            let coverArtContainer = try coversContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKeys.self)
            let coverArt = try coverArtContainer.decode(String.self, forKey: .url)
            covers.append(coverArt)
        }
        self.coverArt = covers
        
    }
}

struct Song: Codable {
    let duration: String
    let id: String
    let name: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationDescriptionCodingKey: String, CodingKey {
        case duration
    }
    
    enum NameDescriptionCodingKey: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameDescriptionCodingKey.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationDescriptionCodingKey.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
    }
}
