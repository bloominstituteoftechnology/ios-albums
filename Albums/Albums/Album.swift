//
//  Album.swift
//  Albums
//
//  Created by Nonye on 5/7/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
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
        
        //MARK: - ALBUM CODING KEYS
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        coverArt = []
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        //MARK: - TODO
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
}

struct Song: Decodable {
    let duration: String
    let id: String
    let title: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        let durationKeyContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        let nameKeyContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .name)
        
        duration = try durationKeyContainer.decode(String.self, forKey: .duration)
        id = try container.decode(String.self, forKey: .id)
        title = try nameKeyContainer.decode(String.self, forKey: .title)
    }
}
