//
//  Album.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

struct Album: Codable, Equatable {
    var artist: String
    var name: String
    var id: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case artist
        case name
        case id
        case coverArt
        case genres
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(String.self, forKey: .id)
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genres: [String] = []
        
        while !genresContainer.isAtEnd {
            
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArt: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            
            let art = try coverArtURLContainer.decode(String.self, forKey: .url)
            guard let url = URL(string: art) else { continue }
            
            coverArt.append(url)
        }
        
        let songs = try container.decode([Song].self, forKey: .songs)
        
        self.artist = artist
        self.name = name
        self.id = id
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(songs, forKey: .songs)
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genres {
            try genresContainer.encode(genre)
        }
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for art in coverArt {
         
            var coverArtURLContainer = coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            
            try coverArtURLContainer.encode(art.absoluteString, forKey: .url)
        }
    }
    
    init(artist: String, name: String, id: String = UUID().uuidString, genres: [String], coverArt: [URL], songs: [Song]) {
        
        (self.artist, self.name, self.id, self.genres, self.coverArt, self.songs) = (artist, name, id, genres, coverArt, songs)
    }
}


struct Song: Codable, Equatable {
    var name: String
    var duration: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case id
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
        
        enum DurationCodingKey: String, CodingKey {
            case duration
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKey.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        
        self.id = id
        self.name = name
        self.duration = duration
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKey.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
    }
    
    init(id: String = UUID().uuidString, name: String, duration: String) {
        (self.id, self.name, self.duration) = (id, name, duration)
    }
}
