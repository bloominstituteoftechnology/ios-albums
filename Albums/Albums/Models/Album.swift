//
//  Album.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

struct Album {
    
    // MARK: - Properties

    var name: String
    var artist: String
    var identifier: UUID
    var coverArt: [URL]
    var genres: [String]
    var songs: [Song]
    
    // MARK: - Coding Keys

    enum AlbumKeys: String, CodingKey {
        case id
        case name
        case artist
        case coverArt
        case genres
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
}

extension Album: Codable {
    
    // MARK: - Decoder

    init(from decoder: Decoder) throws {

        // { full json }
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        
        self.name = try container.decode(String.self, forKey: .name)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.identifier = try container.decode(UUID.self, forKey: .id)
        
        self.genres = try container.decode([String].self, forKey: .genres)
//        var genres: [String] = []
//        if container.contains(.genres) {
//            var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
//
//            while !genresContainer.isAtEnd {
//                let genre = try genresContainer.decode(String.self)
//                genres.append(genre)
//            }
//        }
//        self.genres = genres

        self.songs = try container.decode([Song].self, forKey: .songs)
//        var songs: [Song] = []
//        if container.contains(.songs) {
//
//            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
//
//            while !songsContainer.isAtEnd {
//                let song = try songsContainer.decode(Song.self)
//
//                songs.append(song)
//            }
//        }
//        self.songs = songs
//
        self.coverArt = []
        if container.contains(.coverArt) {
            // "coverArt": [...]
            var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
            
            while !coverArtArray.isAtEnd {
                // { "url": ... }
                let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                // "url" for the first value inside coverArt
                let url = try coverArtDictionary.decode(URL.self, forKey: .url)
                coverArt.append(url)
            }
        }
    }
    
    // MARK: - Encoder

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(identifier, forKey: .id)
        try container.encode(genres, forKey: .genres)
        
        // Encode CoverArt
        var coverArtArray = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtDictionary = coverArtArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
        for url in coverArt {
            try coverArtDictionary.encode(url, forKey: .url)
        }
        
        // Encode Songs
        try container.encode(songs, forKey: .songs)
//        var songsArray = container.nestedUnkeyedContainer(forKey: .songs)
//        for song in songs {
//            try songsArray.encode(song)
//        }
        
    }
}























