//
//  Album.swift
//  AlbumList
//
//  Created by Bradley Diroff on 4/6/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum URLKey: String, CodingKey {
            case url
        }
        
   /*
        enum SongListKey: String, CodingKey {
            case duration
            case id
            case name
            
            enum DurationKeys: String, CodingKey {
                case duration
            }
            
            enum NameKeys: String, CodingKey {
                case title
            }
        }
     */
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArts: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let urlKeyContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.URLKey.self)
            
            let urlName = try urlKeyContainer.decode(String.self, forKey: .url)
            if let url = URL(string: urlName) {
                coverArts.append(url)
            }
            
        }
        
        coverArt = coverArts
        
        genres = try container.decode([String].self, forKey: .genres)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        
    }
    
}

struct Song: Codable {
    var duration: String
    var id: String
    var name: String
    
    enum SongKey: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKey.self)
          
        let durationContainer = try container.nestedContainer(keyedBy: SongKey.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        id = try container.decode(String.self, forKey: .id)
        
        let titleContainer = try container.nestedContainer(keyedBy: SongKey.NameKeys.self, forKey: .name)
        name = try titleContainer.decode(String.self, forKey: .title)
          
      }
    
}
