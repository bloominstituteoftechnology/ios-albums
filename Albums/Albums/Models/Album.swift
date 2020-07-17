//
//  Album.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum Keys: String, CodingKey {
        case name
        case artist
        case id
        case genres
        case coverArt
        case songs
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
        
        enum SongKeys: String, CodingKey {
            case duration
            case name
            case id
            
            enum TitleKey: String, CodingKey {
                case title
            }
            
            enum DurationKey: String, CodingKey {
                case duration
            }
        }
    }
    
    var name: String
    var artist: String
    var id: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songsArray: [Song] = []
        while songsContainer.isAtEnd == false {
            let songContainer = try songsContainer.nestedContainer(keyedBy: Keys.SongKeys.self)
            
            let songTitleContainer = try songContainer.nestedContainer(keyedBy: Keys.SongKeys.TitleKey.self, forKey: .name)
            let songTitle = try songTitleContainer.decode(String.self, forKey: .title)
            
            let durationContainer = try songContainer.nestedContainer(keyedBy: Keys.SongKeys.DurationKey.self, forKey: .duration)
            let duration = try durationContainer.decode(String.self, forKey: .duration)
            
            let songId = try songContainer.decode(String.self, forKey: .id)
            
            let song = Song(title: songTitle, duration: duration, id: songId)
            songsArray.append(song)
        }
        songs = songsArray
        
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genresArray: [String] = []
        while genresContainer.isAtEnd == false {
            let genreName = try genresContainer.decode(String.self)
            genresArray.append(genreName)
        }
        genres = genresArray
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtStrings: [String] = []
        while coverArtContainer.isAtEnd == false {
            let coverContainer = try coverArtContainer.nestedContainer(keyedBy: Keys.CoverArtKey.self)
            let cover = try coverContainer.decode(String.self, forKey: .url)
            coverArtStrings.append(cover)
        }
        coverArt = coverArtStrings.compactMap { URL(string: $0) }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genres {
            try genresContainer.encode(genre)
        }
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for art in coverArt {
            var coverContainer = coverArtContainer.nestedContainer(keyedBy: Keys.CoverArtKey.self)
            try coverContainer.encode(art.absoluteString, forKey: .url)
        }
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            var songContainer = songsContainer.nestedContainer(keyedBy: Keys.SongKeys.self)
            
            var songTitleContainer = songContainer.nestedContainer(keyedBy: Keys.SongKeys.TitleKey.self, forKey: .name)
            try songTitleContainer.encode(song.title, forKey: .title)
            
            var durationContainer = songContainer.nestedContainer(keyedBy: Keys.SongKeys.DurationKey.self, forKey: .duration)
            try durationContainer.encode(song.duration, forKey: .duration)
            
            try songContainer.encode(id, forKey: .id)
        }
    }
    
}

struct Song: Codable {
    var title: String
    var duration: String
    var id: String
}
