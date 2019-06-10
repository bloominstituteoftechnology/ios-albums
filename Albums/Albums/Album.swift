//
//  Album.swift
//  Albums
//
//  Created by Kobe McKee on 6/10/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    var name: String
    var artist: String
    var id: String
    var genres: [String]
    var coverArt: [String]
    var songs: [Song]

    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case id
        case genres
        case coverArt
        case songs
        
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
    
        genres = try container.decode([String].self, forKey: .genres)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [String] = []
        
        
        while coverArtContainer.isAtEnd == false {
            let coverArtDescriptionContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtKeys.self)
            
            let coverArtURL = try coverArtDescriptionContainer.decode(String.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        
        coverArt = coverArtURLs
        
        songs = try container.decode([Song].self, forKey: .songs)
    }
    
    
    
    func encode(encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        try container.encode(coverArt, forKey: .coverArt)
   
    }
  
}





struct Song: Codable {
    var duration: String
    var id: String
    var name: String
    
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
    }
    
    func encode(from encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(duration, forKey: .duration)
        try container.encode(name, forKey: .name)
        
    }
    
    
}
