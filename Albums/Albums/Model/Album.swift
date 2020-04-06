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
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }

    let artist: String
    let coverArt: [String]
    let id: String
    let name: String
    let genres: [String]
    let songs: [Song]
}

struct Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum durationKeys: String, CodingKey {
            case duration
        }
        
        enum nameKeys: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
}

