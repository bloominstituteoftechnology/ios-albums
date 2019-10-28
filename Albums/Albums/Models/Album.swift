//
//  Album.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Codable {
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtDescriptionKeys: String, CodingKey {
            case url
        }
    }
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
    var name: String
    var songs: [Song]
    
    func encode (to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
        
        var coverArtURLsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for artURL in coverArt {
            var coverArtContainer = coverArtURLsContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtDescriptionKeys.self)
            
            try coverArtContainer.encode(artURL, forKey: .url)
        }
    }
}

extension Album {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverArtURLsContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        
        while !coverArtURLsContainer.isAtEnd {
            let coverArtContainer = try coverArtURLsContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtDescriptionKeys.self)
            
            let coverArtURL = try coverArtContainer.decode(URL.self, forKey: .url)
            coverArtURLs.append(coverArtURL)
        }
        coverArt = coverArtURLs
    }
}
