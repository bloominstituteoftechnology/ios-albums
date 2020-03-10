//
//  Album.swift
//  Albums
//
//  Created by Chris Gonzales on 3/9/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class Song: Codable {
    
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let duration: String
    let name: String
    let id: UUID
    
    enum SongKeys: String, CodingKey{
        case duration
        case id
        case name
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    // MARK: - Initializers
    
    init(name: String, duration: String, id: UUID = UUID()) {
        self.name = name
        self.duration = duration
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        duration = try container.decode(String.self,
                                        forKey: .duration)
        name = try container.decode(String.self,
                                    forKey: .name)
        id = try container.decode(UUID.self,
                                  forKey: .id)
    }
    
    // MARK: - Methods
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        try container.encode(id,
                             forKey: .id)
        try container.encode(duration,
                             forKey: .duration)
        var nameContainer = container.nestedUnkeyedContainer(forKey: .name)
        try nameContainer.encode(name)
    }
}

class Album: Codable {
    
    enum CodingKeys:String, CodingKey {
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
    
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    var artist: String
    var coverArt: [URL] = []
    let id: UUID
    var name: String
    
    
    var genres: [String] = []
    var songs: [Song] = []
    
    // MARK: - Initializers
    
    init(artist: String, coverArt: [URL], name: String,
         genres: [String], songs: [Song], id: UUID = UUID()) {
        self.artist = artist
        self.coverArt = coverArt
        self.name = name
        self.genres = genres
        self.songs = songs
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        artist = try container.decode(String.self,
                                      forKey: .artist)
        coverArt = try container.decode([URL].self,
                                        forKey: .coverArt)
        name = try container.decode(String.self,
                                    forKey: .name)
        genres = try container.decode([String].self,
                                      forKey: .genres)
        id = try container.decode(UUID.self,
                                  forKey: .id)
        songs = try container.decode([Song].self,
                                     forKey: .songs)
    }
    
    // MARK: - Methods
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(artist,
                             forKey: .artist)
        try container.encode(coverArt,
                             forKey: .coverArt)
        try container.encode(songs,
                             forKey: .songs)
        try container.encode(genres,
                             forKey: .genres)
        try container.encode(id,
                             forKey: .id)
    }
}
