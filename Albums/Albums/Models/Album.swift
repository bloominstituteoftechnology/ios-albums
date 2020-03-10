//
//  Album.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Album: Codable, Equatable {
    
    enum AlbumKeys: String, CodingKey {
        case id
        case artist
        case name
        case songs
        case genres
        case coverArt
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
    }
    
    var id: UUID
    var name: String
    var genres: [String]
    var artist: String
    var coverArtURLs: [URL]
    var songs: [Song]
    
    init(id: UUID, name: String, genres: [String], artist: String, coverArtURLs: [URL], songs: [Song] = []) {
        self.name = name
        self.id = id
        self.genres = genres
        self.artist = artist
        self.coverArtURLs = coverArtURLs
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .name)
        
        var coverArtContainerArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtUrls: [URL] = []
        while !coverArtContainerArray.isAtEnd {
            let coverArtContainer = try coverArtContainerArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtUrl = try coverArtContainer.decode(URL.self, forKey: .url)
            coverArtUrls.append(coverArtUrl)
            
        }
        
        coverArtURLs = coverArtUrls
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
        
        try container.encode(genres, forKey: .genres)
        
        var coverArtContainerArray = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for url in coverArtURLs {
            var coverArtContainer = coverArtContainerArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtContainer.encode(url.absoluteString, forKey: .url)
        }
        
    }
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id
    }

}

struct Song: Codable, Equatable {
    
    enum SongKeys: String, CodingKey {
        case id
        case duration
        case name
       
        enum DurationDescptionKeys: String, CodingKey {
            case duration
        }
        
        enum NameDescriptionKeys: String, CodingKey {
            case title
        }
    }
    
    var duration: String
    var id: UUID
    var title: String
    
    init(id: UUID, duration: String, title: String) {
        self.id = id
        self.title = title
        self.duration = duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationDescptionKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.self, forKey: .name)
        title = try nameContainer.decode(String.self, forKey: .title)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationDescptionKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.self, forKey: .name)
        try nameContainer.encode(title, forKey: .title)
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }

}
