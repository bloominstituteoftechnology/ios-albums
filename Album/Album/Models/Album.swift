//
//  Album.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class Album : Codable {
    var id: UUID
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var name: String
    var songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case id
        case artist
        case coverArt
        case genres
        case name
        case songs
        
        enum AlbumCoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init (id: UUID = UUID(), artist:String, coverArt: [URL], genres: [String], name: String, songs: [Song] = []) {
        self.id = id
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.name = name
        self.songs = songs
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            print ("Album ID: \(id)")
            name = try container.decode(String.self, forKey: .name)
            print ("Album Name: \(name)")
            artist = try container.decode(String.self, forKey: .artist)
            print ("Album Artist: \(artist)")
            var coverArtStrings: [String] = []
            var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while !coverArtContainer.isAtEnd {
                let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.AlbumCoverArtCodingKeys.self)
                let coverArtString = try coverArtURLContainer.decode(String.self, forKey: .url)
                coverArtStrings.append(coverArtString)
            }
            coverArt = coverArtStrings.compactMap {URL(string: $0)}
            print ("Album Cover Art: \(coverArt)")
            var genreStrings: [String] = []
            var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
            while !genreContainer.isAtEnd {
                let genre = try genreContainer.decode(String.self)
                genreStrings.append(genre)
            }
            genres = genreStrings.compactMap { $0 }
            print ("Album Genres: \(genres)")
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            var songArray:[Song] = []
            while !songsContainer.isAtEnd {
                let song: Song  = try songsContainer.decode(Song.self)
                songArray.append(song)
            }
            songs = songArray
        } catch {
            print (error)
            throw (error)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        try container.encode(artist, forKey: .artist)
        var coverArtContainer = container.nestedContainer(keyedBy: AlbumCodingKeys.AlbumCoverArtCodingKeys.self, forKey: .coverArt)
        for url in coverArt {
            try coverArtContainer.encode(url.description, forKey: .url)
        }
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        try genresContainer.encode(contentsOf: genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        var songContainer = container.nestedUnkeyedContainer(forKey: .songs)
        try songContainer.encode(contentsOf: songs)
    }
}
