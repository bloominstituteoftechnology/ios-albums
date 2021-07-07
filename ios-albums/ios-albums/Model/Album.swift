//
//  Album.swift
//  ios-albums
//
//  Created by Nikita Thomas on 11/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var imageURL: String
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
        
        enum SongsCodingKeys: String, CodingKey {
            case duration
            case id
            case name
        }
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKey: String, CodingKey {
            case title
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var artContainer = coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
        try artContainer.encode(imageURL, forKey: .url)
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genres {
            try genresContainer.encode(genre)
        }
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            var songObjectContainer = songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            var durationContainer = songObjectContainer.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
            try durationContainer.encode(song.duration, forKey: .duration)
            
            try songObjectContainer.encode(song.id, forKey: .id)
            
            var songNameContainer = songObjectContainer.nestedContainer(keyedBy: CodingKeys.NameCodingKey.self, forKey: .name)
            try songNameContainer.encode(song.title, forKey: .title)
        }
        
    }
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.coverArt)
        let url = try coverArtContainer.decode(String.self)
        
        var genres: [String] = []
        var genresContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.genres)
        while !genresContainer.isAtEnd {
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.songs)
        var songs: [Song] = []
        
        while !songsContainer.isAtEnd {
            let songContainer = try songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            let songID = try songContainer.decode(String.self, forKey: .id)
            
            let durationContainer = try songContainer.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
            let songDuration = try durationContainer.decode(String.self, forKey: .duration)
            
            let nameContainer = try songContainer.nestedContainer(keyedBy: CodingKeys.NameCodingKey.self, forKey: .name)
            let songTitle = try nameContainer.decode(String.self, forKey: .title)
            
            let newSong = Song(duration: songDuration, id: songID, title: songTitle)
            songs.append(newSong)
        }
        
        self.artist = artist
        self.id = id
        self.name = name
        self.genres = genres
        self.songs = songs
        self.imageURL = url
    }
    
}

struct Song: Decodable {
    var duration: String
    var id: String
    var title: String
}
