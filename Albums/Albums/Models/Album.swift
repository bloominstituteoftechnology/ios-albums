//
//  Album.swift
//  Albums
//
//  Created by morse on 12/2/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

struct Album: Codable, Equatable {
    
    var id: String
    var name: String
    var artist: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
    
    init(id: String, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
        self.id = id
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
    
    enum AlbumDecodingKeys: String, CodingKey {
        case id, name, artist, genres, coverArt, songs
    }
    
    enum CoverArtDecodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumDecodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.genres = try container.decode([String].self, forKey: .genres)
        
        var coverArtURLs: [URL] = []
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        while !coverArtContainer.isAtEnd {
            let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtDecodingKeys.self)
            
            let coverArtURLString = try urlContainer.decode(String.self, forKey: .url)
//            print("Here's the string: \(coverArtURLString)")
            
            if let url = URL(string: coverArtURLString) {
//                print("Here's the URL: \(url)")
                coverArtURLs.append(url)
            }
        }
        
        self.coverArt = coverArtURLs
        
        var songs: [Song] = []
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            
            songs.append(song)
        }
        
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumDecodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        

        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: CoverArtDecodingKeys.self)
        
        for url in coverArt {
            try urlContainer.encode(url.absoluteString, forKey: .url) // Have tried url, "\(url)", & url.absoluteString
        }
        
        
        
        
        try container.encode(songs, forKey: .songs)
        
    }
}

struct Song: Codable, Equatable {
    let id: String
    let name: String
    let duration: String
    
    init(id: String, name: String, duration: String) {
        self.id = id
        self.name = name
        self.duration = duration
    }
    
    enum SongDecodingKeys: String, CodingKey {
        case id, name, duration
        
        enum NameDecodingKeys: String, CodingKey {
            case title
        }
        
        enum DurationDecodingKeys: String, CodingKey {
            case duration
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongDecodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongDecodingKeys.NameDecodingKeys.self, forKey: .name)
        
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongDecodingKeys.DurationDecodingKeys.self, forKey: .duration)
        
        self.duration = try durationContainer.decode(String.self, forKey: SongDecodingKeys.DurationDecodingKeys.duration)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongDecodingKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongDecodingKeys.NameDecodingKeys.self, forKey: .name)
        
        try nameContainer.encode(name, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: SongDecodingKeys.DurationDecodingKeys.self, forKey: .duration)
        
        try durationContainer.encode(duration, forKey: .duration)
    }
}
