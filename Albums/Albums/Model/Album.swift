//
//  Album.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case genres
        case albumName = "name"
        case songs
        case coverArt
        case id
        
        enum CoverArtKey: String, CodingKey {
            case url
        }
        
        enum SongsKey: String, CodingKey {
            case song
        }
        
        
    }
    
    let artist: String
    let genres: [String]
    let albumName: String
    var songs: [Song]
    let coverArt: [URL]
    let id: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        albumName = try container.decode(String.self, forKey: .albumName)
        id = try container.decode(String.self, forKey: .id)
        artist = try container.decode(String.self, forKey: .artist)
        let coverArtContainer = try container.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self, forKey: .coverArt)
        coverArt = try coverArtContainer.decode([URL].self, forKey: .url)
        var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        genres = try genreContainer.decode([String].self)
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        songs = try songsContainer.decode([Song].self)
        
    }
    
    
    
}

class Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
            case seconds
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        id = try container.decode(String.self, forKey: .id)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
    }
    
}
