//
//  Album.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Album: Decodable, Encodable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum AllCoverArt: String, CodingKey {
            case url
        }
        
    }
    
    
    
    // MARK: - Codable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        
         // coverArt contains an array -> unkeyed container
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArtURLs: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let allCoverArtContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.AllCoverArt.self)
            let coverArtURLString = try allCoverArtContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: "\(coverArtURLString)") {
                coverArtURLs.append(coverArtURL)
            }
        }
        let coverArt = coverArtURLs
        
        // genre contains an array, but not nested
       let genres = try container.decode([String].self, forKey: .genres)
        
        // id not nested inside anything
       let id = try container.decode(String.self, forKey: .id)
        
        // name not nested in anything
       let name = try container.decode(String.self, forKey: .name)
        
        // songs is an array of the Songs struct
       let songs = try container.decode([Song].self, forKey: .songs)
        
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    
     // MARK: - Encodable
    
     func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for art in coverArt {
            try coverArtContainer.encode(art.absoluteString)
        }
        
        try container.encode(genres, forKey: .genres)
        
        try container.encode(id, forKey: .id)
        
        try container.encode(name, forKey: .name)
        
        try container.encode(songs, forKey: .songs)
        
        
    }
    
}
