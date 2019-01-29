//
//  Album.swift
//  ios-albums
//
//  Created by TuneUp Shop  on 1/28/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    let artist: String
    let coverArt: URL
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumKeys: CodingKey {
        case artist
        case coverArt
        case genres
        case name
        case id
        case songs
        
        enum CoverArt: String, CodingKey {
            case url
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverArtTopContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let coverArtContainer = try coverArtTopContainer.nestedContainer(keyedBy: AlbumKeys.CoverArt.self)
        
        coverArt = try coverArtContainer.decode(URL.self, forKey: .url)
        
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        var coverArtTopContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtContainer = coverArtTopContainer.nestedContainer(keyedBy: AlbumKeys.CoverArt.self)
        
        try coverArtContainer.encode(coverArt, forKey: .url)
    
    }
}

struct Song: Codable {
    
    let duration: String
    let id: String
    let name: String
    
    enum SongKeys: CodingKey {
        case duration
        case id
        case name
        
        enum Duration: String, CodingKey {
            case duration
        }
        
        enum Name: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.Name.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        try container.encode(id, forKey: .id)
        
        _ = container.nestedContainer(keyedBy: SongKeys.self, forKey: .duration)
        _ = container.nestedContainer(keyedBy: SongKeys.Name.self, forKey: .name)
        
    }
}


//let data = try Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))
