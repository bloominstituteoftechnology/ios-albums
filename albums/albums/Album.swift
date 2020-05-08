//
//  Album.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: [CoverArt]
    let genres: [String]
    let id, name: String
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    init(artist: String, coverArt: [CoverArt], genres: [String], id: String, name: String, songs: [Song]) {
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
    }
}


struct CoverArt: Codable {
    let url: URL
    
    enum CoverArtKey: String, CodingKey {
        case url
    }
    init(url: URL) {
        self.url = url
    }
}

struct Song: Codable {
    let name: Name
    let duration: Duration
    
    enum SongKeys: String, CodingKey {
        case name
        case duration
    }
    
    init(name: Name, duration: Duration) {
        self.name = name
        self.duration = duration
    }
}

struct Duration: Codable {
    let duration: String
    
    enum DurationKey: String, CodingKey {
        case duration
    }
    
    init(duration: String) {
        self.duration = duration
    }
}

struct Name: Codable {
    let title: String
    
    enum NameKey: String, CodingKey {
        case title
    }
    
    init(title: String) {
        self.title = title
    }
}
