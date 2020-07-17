//
//  Album.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id, name: String
    var songs: [Song]
    
    init(id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        self.id = id
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.songs = try container.decode([Song].self, forKey: .songs)
        self.coverArt = []
        
        var coverArtUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        while !coverArtUnkeyedContainer.isAtEnd {
            let coverArtKeyedContainer = try coverArtUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
            
            let url = try coverArtKeyedContainer.decode(URL.self, forKey: .url)
            coverArt.append(url)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try! container.encode(self.id, forKey: .id)
        try! container.encode(self.name, forKey: .name)
        try! container.encode(self.artist, forKey: .artist)
        try! container.encode(self.genres, forKey: .genres)
        try! container.encode(self.songs, forKey: .songs)
        
        var coverArtUnkeyedContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtKeyedContainer = coverArtUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
        
        for url in coverArt {
            try! coverArtKeyedContainer.encode(url, forKey: .url)
        }
    }
}

struct Song: Codable {
    let title: String
    let duration: String
    let id: String
    
    init(title: String, duration: String, id: String) {
        self.title = title
        self.duration = duration
        self.id = id
    }
    
    enum SongKeys: String, CodingKey {
        case name, duration, id
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        let durationKeyedContainer = try container.nestedContainer(keyedBy: SongKeys.DurationCodingKeys.self, forKey: .duration)
        let nameKeyedContainer = try container.nestedContainer(keyedBy: SongKeys.NameCodingKeys.self, forKey: .name)
        
        self.duration = try durationKeyedContainer.decode(String.self, forKey: .duration)
        self.title = try nameKeyedContainer.decode(String.self, forKey: .title)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        var durationKeyedContainer = container.nestedContainer(keyedBy: SongKeys.DurationCodingKeys.self, forKey: .duration)
        var nameKeyedContainer = container.nestedContainer(keyedBy: SongKeys.NameCodingKeys.self, forKey: .name)
        
        try! container.encode(self.id, forKey: .id)
        try! durationKeyedContainer.encode(self.duration, forKey: .duration)
        try! nameKeyedContainer.encode(self.title, forKey: .title)
    }
}
