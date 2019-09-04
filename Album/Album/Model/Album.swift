//
//  Album.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Album: Decodable, Encodable {
    var artist: String
    var coverArt: URL
    var genres: [String]
    let id: String
    var name: String
    var songs: [Song]?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    init(artist: String, genres: [String], name: String, coverArt: URL) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = UUID().uuidString
        self.name = name
        self.songs = []
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
        coverArt = try urlContainer.decode(URL.self, forKey: .url)
        
        //var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        
        genres = try container.decode([String].self, forKey: .genres)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        songs = try? container.decode([Song].self, forKey: .songs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(artist, forKey: .artist)
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
        try urlContainer.encode(coverArt.absoluteString, forKey: .url)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
    }
}
