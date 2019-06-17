//
//  Album.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case genres
        case albumName = "name"
        case songs
        case coverArt
        case id
    }
    
    let artist: String
    let genres: [String]
    let albumName: String
    let songs: [Song]
    let coverArt: [URL]
    let id: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        albumName = try container.decode(String.self, forKey: .albumName)
        id = try container.decode(String.self, forKey: .id)
        artist = try container.decode(String.self, forKey: .artist)
        coverArt = try container.decode([URL].self, forKey: .coverArt)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
    
    
    
}

class Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    let duration: String
    let id: String
    let name: String
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        duration = try container.decode(String.self, forKey: .duration)
        
    }
    
}
