//
//  Album.swift
//  Albums
//
//  Created by Dennis Rudolph on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Codable, Equatable {
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        if lhs.id != rhs.id {
            return false
        } else {
            return true
        }
    }

    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
    var name: String
    var songs: [Song]
    
    enum Keys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
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
        let container = try decoder.container(keyedBy: Keys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        while coverArtContainer.isAtEnd == false {
            let artContainer = try coverArtContainer.nestedContainer(keyedBy: Keys.CoverArtKeys.self)
            let coverArtURL = try artContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        coverArt = coverArtURLs
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var albumGenres = [String]()
        while genresContainer.isAtEnd == false {
            let theGenre = try genresContainer.decode(String.self)
            albumGenres.append(theGenre)
        }
        genres = albumGenres
        
        id = try container.decode(UUID.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var artContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for url in coverArt {
            try artContainer.encode(url)
        }

        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genres {
            try genresContainer.encode(genre)
        }

        try container.encode(id, forKey: .id)

        try container.encode(name, forKey: .name)

        try container.encode(songs, forKey: .songs)
    }
}

struct Song: Codable {
    
    var duration: String
    var id : UUID
    var name: String
    
    enum SongKeys: String, CodingKey {
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
    
    init(duration: String, id: UUID, name: String) {
        self.duration = duration
        self.id = id
        self.name = name 
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)

        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)

        try container.encode(id, forKey: .id)

        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
