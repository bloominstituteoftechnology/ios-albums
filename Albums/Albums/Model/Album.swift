//
//  Album.swift
//  Albums
//
//  Created by Jonalynn Masters on 10/28/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation

// MARK: Album Model

struct Album: Decodable {
    
    let artist: String
    let name: String
    let coverArt: [URL]
    let id: String
    let genres: [String]
//    let URL: String
    
    let songs: [Songs]
    
    init(name: String, artist: String, coverArt: [URL], id: String, genres: [String], songs: [Songs]) {
        self.name = name
        self.artist = artist
        self.coverArt = coverArt
        self.id = id
        self.genres = genres
        self.songs = songs
    }
    enum AlbumKeys: String, CodingKey {
        
        case artist
        case name
        case coverArt
        case id
        case genres
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    // MARK: Album Decoder init
    init(from decoder: Decoder) throws {
    
        let container = try decoder.container(keyedBy: AlbumKeys.self)
    
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Songs].self, forKey: .songs)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
            var coverArtURLs: [URL] = []
            
            while coverArtContainer.isAtEnd == false {
                
        let coverArtDescriptionContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                
        let coverArtURL = try coverArtDescriptionContainer.decode(String.self, forKey: .url)
        guard let url = URL(string: coverArtURL) else { continue }
                coverArtURLs.append(url)
            }
            coverArt = coverArtURLs
    }
}

// MARK: Song Model
struct Songs: Decodable {
        
    let name: String
    let id: String
    let duration: String
        
    init(name: String, id: String, duration: String) {
        self.name = name
        self.id = id
        self.duration = duration
    }
        
    enum CodingKeys: String, CodingKey {
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

// MARK: Song Decoder init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
}
