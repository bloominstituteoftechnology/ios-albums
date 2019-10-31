//
//  Album.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

struct Album: Codable {
    let id: String
    let name: String
    let artist: String
    let coverArt: [String]
    let genres: [String]
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case coverArt
        case genres
        case songs
    }
    
    enum CoverArtCodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        
        var genres = [String]()
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        while !genresContainer.isAtEnd {
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        self.genres = genres
        
        var covers = [String]()
        var coversContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coversContainer.isAtEnd {
            let cover = try coversContainer.decode(String.self)
            covers.append(cover)
        }
        self.coverArt = covers
        
        var songs = [Song]()
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        self.songs = songs
        
    }
}

struct Song: Codable {
    let duration: String
    let id: String
    let name: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationDescriptionCodingKey: String, CodingKey {
        case duration
    }
    
    enum NameDescriptionCodingKey: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameDescriptionCodingKey.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationDescriptionCodingKey.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
    }
}
