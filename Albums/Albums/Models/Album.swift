//
//  Album.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

struct Album {
    
    var artist: String
    var coverArtURLs: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
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
    
    init(from decoder: Decoder) throws {
        
        // { full json }
        let jsonContainer = try decoder.container(keyedBy: AlbumKeys.self)
        
        self.artist = try jsonContainer.decode(String.self, forKey: .artist)
        self.genres = try jsonContainer.decode([String].self, forKey: .genres)
        self.id = try jsonContainer.decode(String.self, forKey: .id)
        self.name = try jsonContainer.decode(String.self, forKey: .name)
        self.songs = try jsonContainer.decode([Song].self, forKey: .songs)
        self.coverArtURLs = []
        
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
    
    func encode(to encoder: Encoder) throws {
        var jsonContainer = encoder.container(keyedBy: AlbumKeys.self)
        
        try! jsonContainer.encode(self.id, forKey: .id)
        try! jsonContainer.encode(self.name, forKey: .name)
        try! jsonContainer.encode(self.artist, forKey: .artist)
        try! jsonContainer.encode(self.genres, forKey: .genres)
        try! jsonContainer.encode(self.songs, forKey: .songs)
        
        var coverArtUnkeyedContainer = jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtKeyedContainer = coverArtUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                
        for url in coverArtURLs {
            try! coverArtKeyedContainer.encode(url, forKey: .url)
        }
    }
}
