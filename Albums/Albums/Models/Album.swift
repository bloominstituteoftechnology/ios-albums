//
//  Album.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var albumTitle: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case albumTitle = "name"
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(artist: String, coverArt: [URL], genres: [String], id: String, albumTitle: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.albumTitle = albumTitle
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        albumTitle = try container.decode(String.self, forKey: .albumTitle)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
        // coverArt
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        
        while coverArtContainer.isAtEnd == false {
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtString = try coverArtURLContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: coverArtString) {
                coverArtURLs.append(coverArtURL)
            }
        }
        
        coverArt = coverArtURLs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(artist, forKey: .artist)
        try container.encode(albumTitle, forKey: .albumTitle)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        try container.encode(coverArt, forKey: .coverArt)
        
//        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
//        for url in coverArt {
//            try coverArtContainer.encode(url.absoluteString)
//        }
    }
}

struct Song: Codable {
    var duration: String
    var id: String
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
    
    init(duration: String, id: String, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let songDurationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try songDurationContainer.decode(String.self, forKey: .duration)
        
        let songNameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try songNameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
