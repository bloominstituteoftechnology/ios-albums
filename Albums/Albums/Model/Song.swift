//
//  Song.swift
//  Albums
//
//  Created by Harmony Radley on 4/9/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

struct Song: Decodable {
    
    let id: String
    let duration: String
    let title: String
    
    private enum SongCodingKeys: String, CodingKey {
        case id
        case duration
        case name
        
        
        enum DurationCodingKeys: String, CodingKey {
            case timeLength = "duration"
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
        
    }
    init(from decoder: Decoder) throws {
        // SongsCodingKeys
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        
        // DurationCodingKeys
        var durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .timeLength)
        
        //NameCodingKeys
        var nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        self.title = try nameContainer.decode(String.self, forKey: .title)
    }
    
}


struct Album: Decodable {
    var artist: String
    var coverArt: [String]
    var url: String
    var genres: [String]
    var name: String
    var songs: [Song]
    
    private enum AlbumCodingKeys: String, CodingKey {
        case artist
        case name
        case coverArt
        case genres
        case id
        case songs
        
        enum CoverArtCodingKey: String, CodingKey {
            case url
        }
    }
    
    
    init(decoder: Decoder) throws {
        
        // Album CodingKeys
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        self.artist = try container.decode(String.self, forKey:  .artist)
        self.name = try container.decode(String.self, forKey:  .name)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.id = try container.decode(String.self, forKey: .id)
        
        // Songs Array
        var songs = [Song]()
        if container.contains(.songs) {
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            
            while !songsContainer.isAtEnd {
                let song = try songsContainer.decode(Song.self)
                songs.append(song)
            }
        }
        
        self.songs = songs
    }
    
    
    
    
}


