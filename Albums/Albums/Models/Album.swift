//
//  Album.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum GenreContentKeys: String, CodingKey {
            case genre
            
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        let _ = try container.nestedUnkeyedContainer(forKey: .coverArt)
        coverArt = try container.decode([URL].self, forKey: .coverArt)
        
        var genresNames: [String] = []
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        while !genresContainer.isAtEnd {
            let genreContentContainer = try genresContainer.nestedContainer(keyedBy: AlbumKeys.GenreContentKeys.self)
            let genreName = try genreContentContainer.decode(String.self, forKey: .genre)
            genresNames.append(genreName)
        }
        genres = genresNames
        
        id = try container.decode(String.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        songs = try songsContainer.decode([Song].self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(coverArt, forKey: .coverArt)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
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
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        duration = try container.decode(String.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(duration, forKey: .duration)
    }
}
