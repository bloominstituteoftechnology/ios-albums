//
//  Album.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation


struct Album: Codable {
    
    // MARK: - Enums
    
    enum AlbumCodey: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        
        enum CoverArtsyCodey: String, CodingKey {
            case url
        }
        
    }
    
    // MARK: - Properties
    
    let artist: String
    let coverArt : [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    // MARK: - Initializers
    
    init(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodey.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        self.songs = try container.decode([Song].self, forKey: .songs)
        
        self.genres = try container.decode([String].self, forKey: .genres)
        
        var urlContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverURLs: [String] = []
        
        while !urlContainer.isAtEnd {
            let urlStringContainer = try urlContainer.nestedContainer(keyedBy: AlbumCodey.CoverArtsyCodey.self)
            let urlString = try urlStringContainer.decode(String.self, forKey: .url)
            coverURLs.append(urlString)
        }
        
        self.coverArt = coverURLs.compactMap { URL(string: $0) }
        
    }
    
    // MARK: - Methods
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumCodey.self)
        
        try container.encode(artist, forKey: .artist)
        
        try container.encode(id, forKey: .id)
        
        try container.encode(name, forKey: .name)
        
        try container.encode(songs, forKey: .songs)
        
        try container.encode(genres, forKey: .genres)
        
        var urlContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for cover in coverArt {
            var urlStringContainer = urlContainer.nestedContainer(keyedBy: AlbumCodey.CoverArtsyCodey.self)
            try urlStringContainer.encode(cover, forKey: .url)
            
        }
        
        
    }
    
}

// MARK: - Sub property models

struct Song: Codable {
    
    enum SongyCodey: String, CodingKey {
        case duration
        case id
        case name
        
        enum SongDurationKey: String, CodingKey {
            case duration
        }
        
        enum SongTitleKey: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id : String
    let title: String
    
    // MARK: - Initializers
    
    init(duration: String, id: String, title: String) {
        self.duration = duration
        self.id = id
        self.title = title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongyCodey.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongyCodey.SongDurationKey.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongyCodey.SongTitleKey.self, forKey: .name)
        self.title = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongyCodey.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: SongyCodey.SongDurationKey.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongyCodey.SongTitleKey.self, forKey: .name)
        try nameContainer.encode(title, forKey: .title)
        
    }
    
}

