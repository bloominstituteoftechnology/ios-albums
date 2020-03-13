//
//  Album.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/11/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
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
    
    // For Codable
    init(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        var coverArtURLs = [URL]()
        var coverArtOuterContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtOuterContainer.isAtEnd {
        let coverArtContiner = try coverArtOuterContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
        let coverArtURL = try coverArtContiner.decode(URL.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        coverArt = coverArtURLs
    }
    
    // encoder - From SWIFT to Json
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtInnerContainer = container.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self, forKey: .coverArt)
        for coverArtURL in coverArt {
            try coverArtInnerContainer.encode(coverArtURL, forKey: .url)
        }
        
    }
    
    
    
    
    struct Song: Codable {
        var id: String
        var duration: String
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
        
        init(id: String, duration: String, name: String) {
            self.id = id
            self.duration = duration
            self.name = name
    }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: SongKeys.self)
            id = try container.decode(String.self, forKey: .id)
            
            let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
            name = try nameContainer.decode(String.self, forKey: .title)
            
            let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
            duration = try durationContainer.decode(String.self, forKey: .duration)
       }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: SongKeys.self)
            try container.encode(id, forKey: .id)
            
            var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
            try nameContainer.encode(name, forKey: .title)
            
            var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
            try durationContainer.encode(duration, forKey: .duration)
        }    
}
}


