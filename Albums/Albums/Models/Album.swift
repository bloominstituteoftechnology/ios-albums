//
//  Album.swift
//  Albums
//
//  Created by Gi Pyo Kim on 10/28/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
    }
    init(artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let urlString = try coverArtContainer.decode([String:String].self)
        let url = urlString.compactMap { URL(string: $0.value) }
        coverArt = url
        
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genreNames: [String] = []
        while !genresContainer.isAtEnd {
            let genreName = try genresContainer.decode(String.self)
            genreNames.append(genreName)
        }
        genres = genreNames
        
        id = try container.decode(UUID.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        songs = try container.decode([Song].self, forKey: .songs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for url in coverArt {
            try coverArtContainer.encode(url)
        }
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for name in genres {
            try genresContainer.encode(name)
        }
        
        try container.encode(id, forKey: .id)
        
        try container.encode(name, forKey: .name)
        
        try container.encode(songs, forKey: .songs)
    }
}

struct Song: Codable {
    var duration: String
    var id: UUID
    var name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        enum nameKeys: String, CodingKey {
            case title
        }
    }
    init(duration: String, id: UUID, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        do {
            id = try container.decode(UUID.self, forKey: .id)
        } catch {
            NSLog("Cannot decode id:\(error)")
            id = UUID()
        }
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.nameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.nameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}

