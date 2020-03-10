//
//  Album.swift
//  Album
//
//  Created by Christy Hicks on 1/21/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

typealias CoverArtTuple = (size: String, url: URL)

// MARK: - Coding Keys
enum AlbumCodingKeys: String, CodingKey {
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

class Album: Codable {
    // MARK: - Properties
    var artist: String
    var name: String
    var identifier: UUID
    var coverArt: [URL]
    var genres: [String]
    var songs: [Song]
    
    // MARK: - Initializers
    init(name: String, artist: String, identifier: UUID = UUID(), coverArt: [URL], genres: [String], songs: [Song]) {
        self.name = name
        self.artist = artist
        self.identifier = identifier
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let artist = try container.decode(String.self, forKey: .artist)
        let identifier = try container.decode(UUID.self, forKey: .id)
        
        var coverArt: [URL] = []
        
        if container.contains(.coverArt) {
            var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
            
            while !coverArtArray.isAtEnd {
                let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: AlbumCodingKeys.CovertArtKeys.self)
                let url = try coverArtDictionary.decode(URL.self, forKey: .url)
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
    
    // MARK: Methods
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(identifier, forKey: .id)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CovertArtKeys.self)
        for url in coverArt {
            try urlContainer.encode(url, forKey: .url)
        }
        
        try container.encode(genres, forKey: .genres)
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            try songsContainer.encode(song)
        }
    }
}
