//
//  Album.swift
//  Albums
//
//  Created by Ciara Beitel on 9/30/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum SongContentKeys: String, CodingKey {
            case song
            
            enum SongAttributeKeys: String, CodingKey {
                case duration
                case id
                case name
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        let coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        coverArt = try container.decode([URL].self, forKey: .coverArt)
        
        var genres: [String] = []
        let genresContainer = try container.nestedContainer(keyedBy: AlbumKeys.self, forKey: .genres)
        let genre = try genresContainer.decode(String.self, forKey: .genres)
            genres.append(genre)
        
        id = try container.decode(String.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
    }
        
}
    

struct Song: Decodable {
    let duration: String
    let id: String
    let name: String
}
