//
//  Album.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
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
    }
    
    enum CoverArtKeys: String, CodingKey {
        case url
    }
    
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        
        let coverartContainer = try container.nestedContainer(keyedBy: CoverArtKeys.self, forKey: .coverArt)
        let coverArtURLString = try coverartContainer.decode(String.self, forKey: .url)
        var coverArtURLs: [URL] = []
        
        if let coverArtURL = URL(string: coverArtURLString) {
            coverArtURLs.append(coverArtURL)
        }
        
        self.coverArt = coverArtURLs
        
    }
}

struct Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationKey: String, CodingKey {
        case duration
    }
    
    enum NameKey: String, CodingKey {
        case title
    }
    
    let duration: String
    let id: String
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationKey.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKey.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
    }
}
