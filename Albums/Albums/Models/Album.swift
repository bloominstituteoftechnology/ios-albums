//
//  Album.swift
//  Albums
//
//  Created by Alex Shillingford on 10/28/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation


// MARK: - ALBUM STRUCT


struct Album: Codable {
    // MARK: - ENUM AlbumKeys
    enum AlbumKeys: String, CodingKey {
        case name
        case artist
        case id
        case genres
        case coverArt
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    // MARK: - Album Properties
    let name: String
    let artist: String
    let id: UUID
    let coverArt: [URL]
    let genres: [String]
    let songs: [Song]
    
    // MARK: Album Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
        do {
            id = try container.decode(UUID.self, forKey: .id)
        } catch {
            let uuidString = try container.decode(String.self, forKey: .id)
            id = UUID(uuidString: uuidString) ?? UUID()
        }
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let urlsContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtURL = try urlsContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        
        self.coverArt = coverArtURLs
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for url in coverArt {
            var coverArtUrlsContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtUrlsContainer.encode(url, forKey: .url)
        }
    }
}

// MARK: - SONG STRUCT

struct Song: Codable {
    
    // MARK: - ENUM SongKeys
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
    
    // MARK: - Song Properties
    let duration: String
    let id: UUID
    let name: String
    
    // MARK: - Song Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        do {
            id = try container.decode(UUID.self, forKey: .id)
        } catch {
            let uuidString = try container.decode(String.self, forKey: .id)
            id = UUID(uuidString: uuidString) ?? UUID()
        }
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
}
