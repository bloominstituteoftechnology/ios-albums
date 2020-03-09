//
//  Album.swift
//  Albums
//
//  Created by Ufuk Türközü on 09.03.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation

struct Album: Codable {
    let name: String
    let artist: String
    let coverArt: [URL]
    var genres: [String]
    let id: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case name
        case artist
        case coverArt
        case genres
        case id
        case songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        let coverArtStrings = try container.decode([String].self, forKey: .coverArt)
        id = try container.decode(String.self, forKey: .id)
        
        var coverArt: [URL] = []
        var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtArray.isAtEnd {
            let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: AlbumKeys.self)
            
            let url = try coverArtDictionary.decode(URL.self, forKey: .coverArt)
            coverArt.append(url)
        }
        self.coverArt = coverArt
        
        var genres: [String] = []
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        
        while !genresContainer.isAtEnd {
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        self.genres = genres
        
        var songs: [Song] = []
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            
            songs.append(song)
        }
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)

        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.self)

        for url in coverArt {
            try urlContainer.encode(url, forKey: .coverArt)
        }

        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)

        for song in songs {
            try songsContainer.encode(song)
        }
    }
}

struct Song: Codable {
    let name: String
    let duration: String
    let id: String
    
    enum SongKeys: String, CodingKey {
        case name
        case duration
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.self, forKey: .duration)
        
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.self, forKey: .name)
        
        name = try nameContainer.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
    }
}
