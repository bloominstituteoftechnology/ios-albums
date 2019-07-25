//
//  Album.swift
//  Albums
//
//  Created by Michael Stoffer on 7/22/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

struct Album: Equatable, Codable {
    enum Keys: String, CodingKey {
        case id
        case name
        case artist
        case coverArt
        case genres
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    var id: String
    var name: String
    var artist: String
    var coverArt: [String]
    var genres: [String]
    var songs: [Song]
    
    init(id: String = UUID().uuidString, name: String, artist: String, coverArt: [String], genres: [String], songs: [Song]) {
        self.id = id
        self.name = name
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtURLsContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [String] = []
        
        while coverArtURLsContainer.isAtEnd == false {
            let coverArtContainer = try coverArtURLsContainer.nestedContainer(keyedBy: Keys.CoverArtKeys.self)
            let coverArtURL = try coverArtContainer.decode(String.self, forKey: .url)
            
            coverArtURLs.append(coverArtURL)
        }
        self.coverArt = coverArtURLs
        
        self.genres = try container.decode([String].self, forKey: .genres)
        
        var songs: [Song] = []
        if container.contains(.songs) {
            var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            while songContainer.isAtEnd == false {
                let song = try songContainer.decode(Song.self)
                songs.append(song)
            }
        }
        self.songs = songs
    }
    
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.artist, forKey: .artist)
        
        var coverArtURLsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArtURL in self.coverArt {
            var coverArtContainer = coverArtURLsContainer.nestedContainer(keyedBy: Keys.CoverArtKeys.self)
            try coverArtContainer.encode(coverArtURL, forKey: .url)
        }
        
        try container.encode(self.genres, forKey: .genres)
        try container.encode(self.songs, forKey: .songs)
    }
}

struct Song: Equatable, Codable {
    enum Keys: String, CodingKey {
        case id
        case name
        case duration
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
    }
    
    let id: String
    let name: String
    let duration: String
    
    init(id: String = UUID().uuidString, name: String, duration: String) {
        self.id = id
        self.name = name
        self.duration = duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: Keys.NameKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: Keys.DurationKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
    }
    
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: Keys.NameKeys.self, forKey: .name)
        try nameContainer.encode(self.name, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: Keys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(self.duration, forKey: .duration)
    }
}
