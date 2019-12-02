//
//  Album.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
    }
    
    let artist: String
    let coverArt: [String]
    let name: String
    let genres: [String]
    let id: String
    let songs: [Song]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        let coverArtContainer = try container.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self, forKey: .coverArt)
        self.coverArt = try coverArtContainer.decode([String].self, forKey: .url)
        
        self.genres = try container.decode([String].self, forKey: .genres)
        self.songs = try container.decode([Song].self, forKey: .songs)
    }
    
}

struct Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKey: String, CodingKey {
            case duration
        }
        
        enum NameKey: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)
        
        name = try nameContainer.decode(String.self, forKey: .title)
    }
}
