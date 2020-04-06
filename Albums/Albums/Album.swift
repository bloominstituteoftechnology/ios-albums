//
//  Album.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct Album {
    let artist: String
    let coverArtURLs: [String]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
}

extension Album: Codable {
    enum AlbumCodingKeys: String, CodingKey {
        case artist, coverArt, genres, id, name, songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs = [String]()
        
        while !coverArtContainer.isAtEnd {
            let coverArtURLDict = try coverArtContainer.decode([String: String].self)
            coverArtURLs.append(contentsOf: coverArtURLDict.values)
        }
        
        self.coverArtURLs = coverArtURLs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for url in coverArtURLs {
            try coverArtContainer.encode(["URL": url])
        }
    }
}

struct Song {
    let duration: String
    let id: String
    let title: String
}

extension Song: Codable {
    enum SongCodingKeys: String, CodingKey {
        case duration, id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        
        let durationDict = try container.decode([String: String].self, forKey: .duration)
        duration = durationDict["duration"] ?? ""
        
        id = try container.decode(String.self, forKey: .id)
        
        let nameDict = try container.decode([String: String].self, forKey: .name)
        title = nameDict["title"] ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        
        try container.encode(["duration": duration], forKey: .duration)
        try container.encode(id, forKey: .id)
        try container.encode(["title": title], forKey: .name)
    }
}


