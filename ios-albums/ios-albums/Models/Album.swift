//
//  Album.swift
//  ios-albums
//
//  Created by Alex Shillingford on 9/30/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation
// MARK: - Album Struct


struct Album: Codable {
    // MARK: - Properties
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    // MARK: - Enum CodingKeys
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
    
    //MARK: - Album Decode initializer
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        // MARK: - artist/id/name/songs
        
        self.artist = try container.decode(String.self, forKey: .artist)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode([Song].self, forKey: .songs)
        
        
        // MARK: - coverArt decoding
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtUrls: [URL] = []
        while !coverArtContainer.isAtEnd {
            let coverArtContentContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let urlValue = try coverArtContentContainer.decode(URL.self, forKey: .url)
            coverArtUrls.append(urlValue)
        }
        self.coverArt = coverArtUrls
        
        
        // MARK: - genres decoding
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genresArray: [String] = []
        while !genresContainer.isAtEnd {
            let genreString = try genresContainer.decode(String.self)
            genresArray.append(genreString)
        }
        self.genres = genresArray
        
    }
    
    // MARK: - Album Encoder method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        // MARK: - artist/id/name/songs
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
        try container.encode(genres, forKey: .genres)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for url in coverArt {
            var coverArtUrlsContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtUrlsContainer.encode(url, forKey: .url)
        }
    }
}

// MARK: - Song Struct
struct Song: Codable {
    let duration: String
    let id: String
    let name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
    }
    
    // MARK: - Song Decode initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
    }
}
