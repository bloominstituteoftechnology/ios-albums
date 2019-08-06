//
//  Album.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var albumTitle: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case albumTitle = "name"
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(artist: String, coverArt: [URL], genres: [String], id: String, albumTitle: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.albumTitle = albumTitle
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        albumTitle = try container.decode(String.self, forKey: .albumTitle)
        
        // coverArt
        var coverArt: [URL] = []
        
        if container.contains(.coverArt) {
            
            var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while !coverArtArray.isAtEnd {
                let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                
                let url = try coverArtDictionary.decode(URL.self, forKey: .url)
                
                coverArt.append(url)
            }
        }
        
        self.coverArt = coverArt
        
        // genres
        var genres: [String] = []
        if container.contains(.genres) {
            
            var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
            
            
            while !genresContainer.isAtEnd {
                let genre = try genresContainer.decode(String.self)
                genres.append(genre)
            }
            
        }
        
        self.genres = genres
        
        //songs
        var songs: [Song] = []
        if container.contains(.songs) {
            
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            
            
            while !songsContainer.isAtEnd {
                let song = try songsContainer.decode(Song.self)
                
                songs.append(song)
            }
        }
        
        self.songs = songs
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(artist, forKey: .artist)
        try container.encode(albumTitle, forKey: .albumTitle)
        try container.encode(genres, forKey: .genres)
        
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
        for url in coverArt {
            try urlContainer.encode(url, forKey: .url)
        }
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            try songsContainer.encode(song)
        }
        
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
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    init(duration: String, id: String, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let songDurationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try songDurationContainer.decode(String.self, forKey: .duration)
        
        let songNameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try songNameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
