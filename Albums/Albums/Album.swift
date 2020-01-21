//
//  Album.swift
//  Albums
//
//  Created by Alex Thompson on 1/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

typealias CoverArtTuple = (size: String, url: URL)

class Album: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case coverArt
        case genres
        case songs
        case id
        
        enum CovertArtKeys: String, CodingKey {
            case url
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let artist = try container.decode(String.self, forKey: .artist)
        let identifier = try container.decode(UUID.self, forKey: .id)
        
        var coverArt: [URL] = []
        
        if container.contains(.coverArt) {
            
            var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while !coverArtArray.isAtEnd {
                let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: CodingKeys.CovertArtKeys.self)
                
                let url = try coverArtDictionary.decode(URL.self, forKey: .url)
                print("This is the url: \(url)")
                
                coverArt.append(url)
            }
        }
        
        var genres: [String] = []
        
        if container.contains(.genres) {
            
            var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
            
            
            while !genresContainer.isAtEnd {
                let genre = try genresContainer.decode(String.self)
                genres.append(genre)
            }
            
        }
        
        var songs: [Song] = []
        if container.contains(.songs) {
            
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            
            
            while !songsContainer.isAtEnd {
                let song = try songsContainer.decode(Song.self)
                
                songs.append(song)
            }
            
        }
        self.name = name
        self.artist = artist
        self.identifier = identifier
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(identifier, forKey: .id)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: CodingKeys.CovertArtKeys.self)
        
        for url in coverArt {
            try urlContainer.encode(url, forKey: .url)
        }
        
        try container.encode(genres, forKey: .genres)
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        
        for song in songs {
            try songsContainer.encode(song)
        }
    }
    
    init(name: String, artist: String, identifier: UUID = UUID(), coverArt: [URL], genres: [String], songs: [Song]) {
        self.name = name
        self.artist = artist
        self.identifier = identifier
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
    }
    
    var artist: String
    var name: String
    var identifier: UUID
    var coverArt: [URL]
    var genres: [String]
    var songs: [Song]
}


class Song: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case id
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
            case seconds
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    init(title: String, identifier: UUID = UUID(), duration: String) {
        self.title = title
        self.identifier = identifier
        self.duration = duration
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let identifier = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        
        let title = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        self.title = title
        self.duration = duration
        self.identifier = identifier
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(identifier, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        
        try nameContainer.encode(title, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        try durationContainer.encode(duration, forKey: .duration)
    }
    
    let title: String
    let identifier: UUID
    let duration: String
}
