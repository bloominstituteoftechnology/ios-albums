//
//  Album.swift
//  albums
//
//  Created by Lambda_School_Loaner_34 on 2/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case name
        case genres
        case songs
    }
    
    let artist: String
    let coverArt: [URL]
    let name: String
    let id: String
    let genres: [String]
    let songs: [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        let artist = try container.decode(String.self, forKeys: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArt: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            var coverArt = try coverArtContainer.decode(String.self)
            
            guard let url = URL(string: coverArt) else { continue }
            coverArt.append(url)
        }
        
        let name = try container.decode(String.self, forKeys: .name)
        let id = try container.decode(String.self, forKeys: .id)
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genres: [Genres] = []
        
        
    
    self.artist = artist
    self.name = name
    self.genres = genres
    self.songs = songs
}

struct Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case duration
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        case name
        enum NameCodingKeys: String, CodingKey {
            case name
        }
        
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: Song.SongKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: Song.SongKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .name)
        
        
        let id = try container.decode(String.self, forKey: .id)
    
        self.duration = duration
        self.name = name
        self.id = id
    
        }

    let duration: String
    let name: String
    let id: String
    }
}
