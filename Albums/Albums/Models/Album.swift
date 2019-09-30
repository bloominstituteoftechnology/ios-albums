//
//  Album.swift
//  Albums
//
//  Created by Jake Connerly on 9/30/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let name: String
    let id: String
    let coverArt: [String]
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
    
    init(decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        // ARTIST, NAME, ID
        let artist = try container.decode(String.self, forKey: .artist)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(String.self, forKey: .id)
        self.artist = artist
        self.name = name
        self.id = id
        
        // COVER ART
        var coverArtURLs: [String] = []
        
        var firstCoverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !firstCoverArtContainer.isAtEnd {
            let secondCoverArtContainer = try firstCoverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let urlString = try secondCoverArtContainer.decode(String.self, forKey: .url)
            coverArtURLs.append(urlString)
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
