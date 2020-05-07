//
//  Album.swift
//  Albums
//
//  Created by Brian Rouse on 5/7/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
//

import Foundation

import Foundation

struct Album: Codable {
    let artist: String
    let name: String
    let id: String
    let coverArt: [URL]
    let genres: [String]
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case name
        case id
        case coverArt
        case genres
        case songs
    
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        // ARTIST, NAME, ID
        let artist = try container.decode(String.self, forKey: .artist)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(String.self, forKey: .id)
        self.artist = artist
        self.name = name
        self.id = id
        
        // COVER ART
        var coverArtURLs: [URL] = []
        if container.contains(.coverArt) {
            var firstCoverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while !firstCoverArtContainer.isAtEnd {
                let secondContainer = try firstCoverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                let url = try secondContainer.decode(URL.self, forKey: .url)
                coverArtURLs.append(url)
            }
        }
        self.coverArt = coverArtURLs
        
        // GENRES
        var genresArray: [String] = []
        
        var firstGenreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        
        while !firstGenreContainer.isAtEnd {
            let genre = try firstGenreContainer.decode(String.self)
            
            genresArray.append(genre)
        }
        self.genres = genresArray
        
        // SONGS
        var songsArray: [Song] = []
        
        var firstSongContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        while !firstGenreContainer.isAtEnd {
            let song = try firstSongContainer.decode(Song.self)
            
            songsArray.append(song)
        }
        self.songs = songsArray
    }
    
    func encode(to encoder: Encoder) {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try? container.encode(artist, forKey: .artist)
    }
}

