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
    var songs: [Song]
    var coverArtURLs: [URL]
    var genres: [String]
    var id: String
    
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
        let jsonContainer = try decoder.container(keyedBy: AlbumKeys.self)
        
        self.artist = try jsonContainer.decode(String.self, forKey: .artist)
        self.id = try jsonContainer.decode(String.self, forKey: .id)
        self.name = try jsonContainer.decode(String.self, forKey: .name)
        self.genres = try jsonContainer.decode([String].self, forKey: .genres)
        self.songs = try jsonContainer.decode([Song].self, forKey: .songs)
        
        self.coverArtURLs = []
        
        if jsonContainer.contains(.coverArt) {
            // "coverArt": [...]
            var coverArtUnkeyedContainer = try jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
            
            while !coverArtUnkeyedContainer.isAtEnd {
                // { "url": ... }
                let coverArtKeyedContainer = try coverArtUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                // "url" for the first value inside coverArt
                let url = try coverArtKeyedContainer.decode(URL.self, forKey: .url)
                coverArtURLs.append(url)
            }
        }
    }
    
    // MARK: - Encoder

    func encode(to encoder: Encoder) throws {
        var jsonContainer = encoder.container(keyedBy: AlbumKeys.self)
        
        try jsonContainer.encode(id, forKey: .id)
        try jsonContainer.encode(name, forKey: .name)
        try jsonContainer.encode(artist, forKey: .artist)
        try jsonContainer.encode(genres, forKey: .genres)
        try jsonContainer.encode(songs, forKey: .songs)
        
        var coverArtUnkeyedContainer = jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
                
        for url in coverArtURLs {
            var coverArtKeyedContainer = coverArtUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtKeyedContainer.encode(url, forKey: .url)
        }
    }
}
