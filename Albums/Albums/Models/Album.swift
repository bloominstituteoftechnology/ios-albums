//
//  Album.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Codable, Equatable {
    
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
    
    var artist: String
    var coverArt: String
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    init(artist: String, coverArt: String,
         genres: [String], id: String,
         name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.songs = try container.decode([Song].self, forKey: .songs)
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
        self.coverArt = try coverArtURLContainer.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
        try coverArtURLContainer.encode(coverArt, forKey: .url)
       
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
    }
    
}

struct Song: Codable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKey: String, CodingKey {
            case duration
        }
        
        enum NameKey: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
    
    init(duration: String, id: String, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)
        
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
