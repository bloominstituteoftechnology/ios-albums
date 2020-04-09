//
//  Album.swift
//  Albums
//
//  Created by Nichole Davidson on 4/9/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [String]
    var url: String
    var genres: [String]
    var name: String
    var songs: [Song]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for songs in songs {
            try songsContainer.encode(songs)
        }
        
        var artistContainer = container.nestedUnkeyedContainer(forKey: .artist)
        try artistContainer.encode(artist)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArt in coverArt {
            try coverArtContainer.encode(coverArt)
        }
        
        var urlContainer = container.nestedUnkeyedContainer(forKey: .url)
        try urlContainer.encode(url)
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genres in genres {
            try genresContainer.encode(genres)
        }
        
        var nameContainer = container.nestedUnkeyedContainer(forKey: .name)
        try nameContainer.encode(name)
        
    }
}

struct Song: Codable {
    enum CodingKeys: String, CodingKey {
        case duration, id, name, title
    }
    var id: String
    var name: Title
    var duration: Duration
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(Title.self, forKey: .name)
        duration = try container.decode(Duration.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
        
        var durationContainer = container.nestedUnkeyedContainer(forKey: .duration)
        try durationContainer.encode(duration)
        
        var idContainer = container.nestedUnkeyedContainer(forKey: .id)
        try idContainer.encode(id)
        
        var nameContainer = container.nestedUnkeyedContainer(forKey: .name)
        try nameContainer.encode(name)
        
    }
    
}

struct Title: Codable {
    var text: String
}

struct Duration: Codable {
    var time: String
}
