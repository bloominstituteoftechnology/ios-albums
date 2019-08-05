//
//  Album.swift
//  Albums
//
//  Created by Kat Milton on 8/5/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

struct Album: Equatable, Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
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
    
    init(artist: String, coverArt: [URL], genres: [String], id: UUID, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var uRLs: [URL] = []
        while !coverArtContainer.isAtEnd {
            let uRLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let url = try uRLContainer.decode(URL.self, forKey: .url)
                uRLs.append(url)
        }
            coverArt = uRLs
        
        genres = try container.decode([String].self, forKey: .genres)
        let idString = try container.decode(String.self, forKey: .id)
        guard let id = UUID(uuidString: idString) else {
            throw NSError() }
        self.id = id
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverURL in coverArt {
            var uRLContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try uRLContainer.encode(coverURL, forKey: .url)
        }
        try container.encode(genres, forKey: .genres)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
    }
    
    
    
    
}



