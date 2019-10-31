//
//  Album.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Album: Decodable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genre
        case id
        case name
        case songs
    }
    
    enum CoverArtKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        /* JSON
         {
            "artist" : "Weezer",
            "coverArt" : [{
                "url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
            }],
            "genre" : [ "Alternative" ],
            "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
            "name" : "Weezer (The Blue Album)",
            "songs" : [{   -SONG-   }]
         }
         */
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        let artContainer = try container.nestedContainer(keyedBy: CoverArtKeys.self, forKey: .coverArt)
        let coverArtURLStrings = try artContainer.decode([String].self, forKey: .url)
        coverArt = coverArtURLStrings.compactMap({ URL(string: $0) })
        
        genres = try container.decode([String].self, forKey: .genre)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        songs = []
        while !songContainer.isAtEnd {
            let aSong = try songContainer.decode(Song.self)
            songs.append(aSong)
        }
    }
}
