//
//  Album.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Album: Codable {
    var id: String
    var name: String
    var artist: String
    var genres: [String]
    var coverArtURLs: [URL]
    var songs: [Song]
    
    init(name: String, artist: String, genres: [String], songs: [Song], coverArtURLs: [URL]) {
        self.name = name
        self.artist = artist
        self.genres = genres
        self.songs = songs
        self.coverArtURLs = coverArtURLs
        
        self.id = UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case genres
        case coverArt
        case songs
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
        coverArtURLs = []
        while !coverArtContainer.isAtEnd {
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtKey.self)
            let coverArtURLString = try coverArtURLContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: coverArtURLString) {
                coverArtURLs.append(coverArtURL)
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var coverArtObjectsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        try coverArtURLs.forEach {
            var coverArtContainer = coverArtObjectsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtKey.self)
            try coverArtContainer.encode($0.absoluteString, forKey: .url)
        }
    }
}

extension Album: Equatable {
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id
    }
}
