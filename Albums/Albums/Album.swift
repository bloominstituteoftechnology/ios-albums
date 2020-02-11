//
//  Album.swift
//  Albums
//
//  Created by Michael on 2/10/20.
//  Copyright © 2020 Michael. All rights reserved.
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
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArtArray = [URL]()
        
        while coverArtContainer.isAtEnd == false {
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let url = try coverArtURLContainer.decode(URL.self, forKey: .url)
            coverArtArray.append(url)
        }
        
        coverArt = coverArtArray
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        let coverArtURLStrings = coverArt.map {
            value in value.absoluteString
        }
        try container.encode(coverArtURLStrings, forKey: .coverArt)
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            try songsContainer.encode(song)
        }
    }
    
    init(artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = UUID().uuidString
        self.name = name
        self.songs = songs
    }
}


struct Song: Codable {
    var duration: String
    var id: String
    var name: String
        
    enum SongKeys: String, CodingKey {
        case durationDescription = "duration"
        case id
        case name
                
        enum DurationKeys: String, CodingKey {
            case duration
                
        }
            
        enum NameKeys: String, CodingKey {
            case title
        }
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationDescriptionContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
            
        duration = try durationDescriptionContainer.decode(String.self, forKey: .duration)
            
        id = try container.decode(String.self, forKey: .id)
            
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
            
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        var durationDescriptionContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
        try durationDescriptionContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
    
    init(duration: String, name: String) {
        self.duration = duration
        self.id = UUID().uuidString
        self.name = name
    }
}

