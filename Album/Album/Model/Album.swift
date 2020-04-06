//
//  Album.swift
//  Album
//
//  Created by Lydia Zhang on 4/6/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import Foundation

struct Song: Codable {
    var name: String
    var duration: String
    var id: UUID
    
    enum SongKey: String, CodingKey {
        case id, name, duration
        
        enum NameKey: String, CodingKey {
            case title
        }
        enum DurationKey: String,CodingKey {
            case duration
        }
    }
    
    init(id: UUID, name: String, duration: String) {
        self.id = id
        self.name = name
        self.duration = duration
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKey.self)
        id = try container.decode(UUID.self, forKey: .id)
       
        let nameContainer = try container.nestedContainer(keyedBy: SongKey.NameKey.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKey.DurationKey.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongKey.self)
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKey.NameKey.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKey.DurationKey.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
    }
}
struct Album: Codable, Equatable {
    var id: UUID
    var coverArt: [URL]
    var name: String
    var artist: String
    var genres: [String]
    var songs: [Song]
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum AlbumKey: String, CodingKey {
        case id, name, artist, genres, songs, coverArt
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
    }
    
    init(id: UUID, name: String, coverArt: [URL], artist: String, genres: [String], songs: [Song]) {
        self.id = id
        self.name = name
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
        self.artist = artist
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKey.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverArtURLs: [URL] = []
        var coverArtContainer1 = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtContainer1.isAtEnd {
            let coverArtContainer = try coverArtContainer1.nestedContainer(keyedBy: AlbumKey.CoverArtKey.self)
            let coverArtURL = try coverArtContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        coverArt = coverArtURLs
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: AlbumKey.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer1 = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArtURL in coverArt {
            var coverArtContainer = coverArtContainer1.nestedContainer(keyedBy: AlbumKey.CoverArtKey.self)
            try coverArtContainer.encode(coverArtURL.absoluteString, forKey: .url)
        }
        
    }
}
