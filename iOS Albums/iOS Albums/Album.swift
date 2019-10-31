//
//  Album.swift
//  iOS Albums
//
//  Created by Dillon P on 10/30/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation

struct Song: Codable {
    let name: String
    let duration: String
    let id: UUID
    
    enum SongKeys: String, CodingKey {
        case name
        case duration
        case id
    }
    
    enum SongNameKeys: String, CodingKey {
        case title
    }
    
    enum SongDurationKeys: String, CodingKey {
        case duration
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let uuid = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: uuid)!
        
        let nameContainer = try container.nestedContainer(keyedBy: SongNameKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongDurationKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id.uuidString, forKey: .id)
        
        var namesContainer = container.nestedContainer(keyedBy: SongNameKeys.self, forKey: .name)
        try namesContainer.encode(name, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: SongDurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
    }
    
    
}

struct Album: Codable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    enum CoverArtCodingKeys: String, CodingKey {
        case url
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        // Get artist name
        self.artist = try container.decode(String.self, forKey: .artist)
        
        // Get cover art URL
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArt: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let coverArtUrlContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
            let coverArtUrl = try coverArtUrlContainer.decode(URL.self, forKey: .url)
            coverArt.append(coverArtUrl)
        }
        
        self.coverArt = coverArt
        
        // Get genres
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        
        var genres: [String] = []
        
        while !genresContainer.isAtEnd {
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        
        self.genres = genres
        
        // Get ID
        self.id = try container.decode(String.self, forKey: .id)
        
        // Get name
        self.name = try container.decode(String.self, forKey: .name)
        
        // Get Songs
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        var songs: [Song] = []
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        
        // Create container - var in the encoder function with no 'try'
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        
        // encode artist
        try container.encode(artist, forKey: .artist)
        
        // encode cover art
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURlsContainer = coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
        try coverArtURlsContainer.encode(coverArt, forKey: .url)
        
        // encode genres
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        try genresContainer.encode(genres)
        
        // encode id
        try container.encode(id, forKey: .id)
        
        // encode name
        try container.encode(name, forKey: .name)
        
        // encode songs
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        try songsContainer.encode(songs)
        
    }
    
}
