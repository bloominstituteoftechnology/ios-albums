//
//  Album.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class Album: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    // Provide a custom description to make the print statements a little prettier.
    var description: String {
        return "'\(name)' by \(artist)"
    }
    
    var id: String
    var name: String
    var artist: String
    var coverArtURLs: [URL]
    var genres: [String]
    var songs: [Song]
    
    // Coding keys for encoding and decoding
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case coverArtURLs = "coverArt"
        case genres
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    // MARK: - Initializers
    init(name: String, artist: String, genres: [String], coverArtURLs: [URL]) {
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArtURLs = coverArtURLs
        self.id = UUID().uuidString
        self.songs = []
    }
    
    // MARK: - Codable
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the easy stuff
        let artist = try container.decode(String.self, forKey: .artist)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        
        // Get the array of cover art url strings
        var coverArtsContainer = try container.nestedUnkeyedContainer(forKey: .coverArtURLs)
        var coverArtURLStrings: [String] = []
        
        // Cycle through them and pull them out of their objects, into the array
        while !coverArtsContainer.isAtEnd {
            let coverArtContainer = try coverArtsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            let coverArtURLString = try coverArtContainer.decode(String.self, forKey: .url)
            coverArtURLStrings.append(coverArtURLString)
        }
        
        // Map the array of strings to an array of URLs
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        
//        // Get the array of genres
//        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
//        var genres: [String] = []
//
//        // Cycle through them and decode them into the array
//        while !genresContainer.isAtEnd {
//            let genre = try genresContainer.decode(String.self)
//            genres.append(genre)
//        }
        // Because nothing special is happening here, try decoding straight to an array of strings.
        // *Update* it seems like it works, we didn't cover this in the lecture so it may not be the right thing to do for some reason.
        let genres = try container.decode([String].self, forKey: .genres)
        
        // Get the array of song objects
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songs: [Song] = []
        
        // Cycle through them and decode them into the array
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        
        // Set all the properties
        self.artist = artist
        self.name = name
        self.id = id
        self.coverArtURLs = coverArtURLs
        self.genres = genres
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode the easy stuff
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        
        // Make an array for the cover art url strings
        var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArtURLs)
        
        // Cycle through them encode them into an object in the array
        for coverArtURL in coverArtURLs {
            var coverArtContainer = coverArtsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            try coverArtContainer.encode(coverArtURL.absoluteString, forKey: .url)
        }
        
        // Encode the genre and song arrays
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
    }
}

