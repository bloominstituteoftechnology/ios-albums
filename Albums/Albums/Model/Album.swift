//
//  Album.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case name
        case genres
        case id
        case songs
        case coverArt
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }

    let name: String
    let id: String
    let genres: [String]
    let artist: String
    let coverArt: [String]
    let songs: [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        genres = try container.decode([String].self, forKey: .genres)
        artist = try container.decode(String.self, forKey: .artist)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtString: [String] = []

        while !coverArtContainer.isAtEnd {
            let coverArtDescriptionContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtURL = try coverArtDescriptionContainer.decode(String.self, forKey: .url)

            coverArtString.append(coverArtURL)
        }
        coverArt = coverArtString
    }
}

struct Song: Decodable {
    
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
    
    let duration: String
    let id: String
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
    }
}

