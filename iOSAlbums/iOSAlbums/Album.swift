//
//  Album.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum CodingKeys: String, CodingKey {
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
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
    var name: String
    var songs: [Song]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        
        var urlContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var artURLs: [URL] = []
        
        while !urlContainer.isAtEnd {
            let artContainer = try urlContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            
            let artURLString = try artContainer.decode(String.self, forKey: .url)
            let artURL = URL(string: artURLString)
            artURLs.append(artURL!)
        }
        
        let genres = try container.decode([String].self, forKey: .genres)
        
        let idString = try container.decode(String.self, forKey: .id)
        let id = UUID(uuidString: idString)!
        
        let name = try container.decode(String.self, forKey: .name)
        
        let songs = try container.decode([Song].self, forKey: .songs)
        
        self.artist = artist
        self.coverArt = artURLs
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var artContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var keyArtContainer = artContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
        for artURL in coverArt {
            try keyArtContainer.encode(artURL.absoluteString, forKey: .url)
        }
        
        var genreContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genres {
            try genreContainer.encode(genre)
        }
        
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
    }
}

struct Song: Codable {
    
    enum CodingKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
    }
    
    var name: String
    var duration: String
    var id: UUID
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let idString = try container.decode(String.self, forKey: .id)
        let id = UUID(uuidString: idString)!
        
        self.name = name
        self.duration = duration
        self.id = id
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
        var durationsContainer = container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
        try durationsContainer.encode(duration, forKey: .duration)
        
        try container.encode(id.uuidString, forKey: .id)
    }
}
