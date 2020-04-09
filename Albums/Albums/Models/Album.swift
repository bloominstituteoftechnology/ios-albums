//
//  Album.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct Album: Codable {
    private enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    let artist: String
    let coverArt: [CoverArt]
    let genres: [String]
    let id, name: String
    let songs: [Song]
    
    init(artist: String, coverArt: [CoverArt], genres: [String], id: String, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
            
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.coverArt = try container.decode([CoverArt].self, forKey: .coverArt)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode([Song].self, forKey: .songs)
    }
    
    func encode(to encode: Encoder) throws {
        var container = encode.container(keyedBy: CodingKeys.self)

        try container.encode(artist, forKey: .artist)
        var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArt in coverArt {
            try coverArtsContainer.encode(coverArt)
        }
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genres {
            try genresContainer.encode(genre)
        }
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            try songsContainer.encode(song)
        }
    }
}

struct CoverArt: Codable {
    private enum CodingKeys: String, CodingKey {
        case url
    }
    let url: URL
    
//    init(decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        url = try container.decode(URL.self, forKey: .url)
//    }
}

struct Song: Codable {
    private enum CodingKeys: String, CodingKey {
        case name
        case duration
    }
    let name: Name
    let duration: Duration
    
    init(name: Name, duration: Duration) {
        self.name = name
        self.duration = duration
    }
    
//    init(decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        duration = try container.decode(Duration.self, forKey: .duration)
//        name = try container.decode(Name.self, forKey: .name)
//    }
}

struct Duration: Codable {
    private enum CodingKeys: String, CodingKey {
        case duration
    }
    let duration: String
    
    init(duration: String) {
        self.duration = duration
    }
    
//    init(decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        duration = try container.decode(String.self, forKey: .duration)
//    }
}

struct Name: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
    }
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
//    init(decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        title = try container.decode(String.self, forKey: .title)
//    }
}
