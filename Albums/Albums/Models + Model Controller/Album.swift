//
//  Album.swift
//  Albums
//
//  Created by Clayton Watkins on 5/14/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct Album: Codable{
    //Keys for decoding
    enum AlbumKeys: CodingKey{
        case artist
        case coverArt
        case genres
        case name
        case id
        case songs
        
        enum CoverArtKeys: CodingKey {
            case url
        }
    }
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let name: String
    let id: String
    let songs: [Song]
    
    init(from decoder: Decoder) throws {
        // Contianer to hold keys
        let container = try decoder.container(keyedBy: AlbumKeys.self)

        // Keys to access code
        self.artist = try container.decode(String.self, forKey: .artist)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.songs = try container.decode([Song].self, forKey: .songs)

        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        while coverArtContainer.isAtEnd == false{
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)

            let url = try coverArtURLContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(url)
        }
        self.coverArt = coverArtURLs
    }
    
    func encode(from encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArtURL in coverArt{
            try coverArtContainer.encode(coverArtURL.absoluteString)
        }
    }
}

struct Song: Codable{
    //Keys For decoding
    enum SongKeys: CodingKey{
        case duration
        case name
        case id
        
        enum DurationKey: CodingKey{
            case duration
        }
        
        enum NameKey: CodingKey{
            case title
        }
    }
    //Song Properties
    let duration: String
    let name: String
    let id: String
    
    //Custom Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)

        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(from encoder: Encoder) throws{
        var container = encoder.container(keyedBy: SongKeys.self)

        try container.encode(id, forKey: .id)
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
