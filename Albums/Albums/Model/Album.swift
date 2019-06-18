//
//  Album.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class Album: Codable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case genres
        case albumName = "name"
        case songs
        case coverArt
        case id
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
        
    }
    
    let artist: String
    let genres: [String]
    let albumName: String
    var songs: [Song]
    let coverArt: [String]
    let id: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        albumName = try container.decode(String.self, forKey: .albumName)
        id = try container.decode(String.self, forKey: .id)
        artist = try container.decode(String.self, forKey: .artist)
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtArray: [String] = []
        
        while coverArtContainer.isAtEnd == false {
            let coverArtString = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
        let x = try coverArtString.decode(String.self, forKey: .url)
            coverArtArray.append(x)

        }
        
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        self.coverArt = coverArtArray
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(albumName, forKey: .albumName)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        var coverArtContainer = container.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self, forKey: .coverArt)
        try coverArtContainer.encode(coverArt, forKey: .url)
        
        
    }
    
    
    
}

class Song: Codable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
            case seconds
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let title: String
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        title = try nameContainer.decode(String.self, forKey: .title)
        id = try container.decode(String.self, forKey: .id)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        try container.encode(id, forKey: .id)
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(title, forKey: .title)
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
    }
    
}
