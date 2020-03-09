//
//  Album.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

struct Album : Codable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
  
}



struct Song: Codable {
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String,CodingKey {
            case duration
        }
        enum NameKeys: String,CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
    
    
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
       let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
         id = try container.decode(String.self, forKey: .id)
        
        
    }
}
