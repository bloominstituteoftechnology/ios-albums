//
//  Album.swift
//  Albums
//
//  Created by Dennis Rudolph on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: UUID
    var name: String
    var songs: [Song]
    
    enum Keys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var artContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let urlDict = try artContainer.decode([String: String].self)
        let urls = urlDict.compactMap { URL(string: $0.value) }
        coverArt = urls
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var albumGenres = [String]()
        while genresContainer.isAtEnd == false {
            let theGenre = try genresContainer.decode(String.self)
            albumGenres.append(theGenre)
        }
        genres = albumGenres
        
        id = try container.decode(UUID.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
}

struct Song: Decodable {
    
    var duration: String
    var id : UUID
    var name: String
    
    enum SongKeys: String, CodingKey {
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
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
}
