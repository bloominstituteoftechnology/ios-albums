//
//  Album.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Album: Codable {
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
    }
    
    enum CoverArtKeys: String, CodingKey {
        case url
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
        /* JSON
         {
            "artist" : "Weezer",
            "coverArt" : [{
                "url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
            }],
            "genres" : [ "Alternative" ],
            "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
            "name" : "Weezer (The Blue Album)",
            "songs" : [{   -SONG-   }]
         }
         */
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var artContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [String] = []
        while !artContainer.isAtEnd {
            let artURLContainer = try artContainer.nestedContainer(keyedBy: CoverArtKeys.self)
            let aURL = try artURLContainer.decode(String.self, forKey: .url)
            coverArtURLs.append(aURL)
        }
        coverArt = coverArtURLs.compactMap({ URL(string: $0) })
        
        genres = try container.decode([String].self, forKey: .genres)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        songs = []
        while !songContainer.isAtEnd {
            let aSong = try songContainer.decode(Song.self)
            songs.append(aSong)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for url in coverArt {
            var urlContainer = coverArtContainer.nestedContainer(keyedBy: CoverArtKeys.self)
            try urlContainer.encode(url, forKey: .url)
        }
        var genreContainer = container.nestedUnkeyedContainer(forKey: .genres)
        try genreContainer.encode(genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        try songsContainer.encode(songs)
    }
}
