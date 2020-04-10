//
//  Album.swift
//  Albums
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    let artist: String
    var coverArtURLs: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist, name, id, songs, genres, coverArt
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.songs = try container.decode([Song].self, forKey: .songs)
        self.coverArtURLs = []
        
        var coverArtUnKeyedContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        while !coverArtUnKeyedContainer.isAtEnd {
            let coverArtKeyedContainer = try coverArtUnKeyedContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKeys.self)
            
            let url = try coverArtKeyedContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(url)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        
        try! container.encode(self.id, forKey: .id)
        try! container.encode(self.name, forKey: .name)
        try! container.encode(self.artist, forKey: .artist)
        try! container.encode(self.genres, forKey: .genres)
        try! container.encode(self.songs, forKey: .songs)
        
        var coverArtUnKeyedContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtKeyedContainer = coverArtUnKeyedContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKeys.self)
        
        for url in coverArtURLs {
            try! coverArtKeyedContainer.encode(url, forKey: .url)
        }
    }


struct Song: Codable {
    let duration: String
    let id: String
    let title: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration, id, name
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        let durationKeyedContainer = try container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        let nameKeyedContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        
        self.duration = try durationKeyedContainer.decode(String.self, forKey: .duration)
        self.title = try nameKeyedContainer.decode(String.self, forKey: .title)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        var durationKeyedContainer = container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        var nameKeyedContainer = container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        
        try! container.encode(self.id, forKey: .id)
        try! durationKeyedContainer.encode(self.duration, forKey: .duration)
        try! nameKeyedContainer.encode(self.title, forKey: .title)
        
    }
    
}
}
