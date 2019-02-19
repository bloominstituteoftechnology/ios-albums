//
//  Album.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

struct Album: Decodable {
    var artist: String
    var name: String
    var id: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case artist
        case name
        case id
        case coverArt
        case genres
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(String.self, forKey: .id)
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genres: [String] = []
        
        while !genresContainer.isAtEnd {
            
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArt: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            
            let art = try coverArtURLContainer.decode(String.self, forKey: .url)
            guard let url = URL(string: art) else { continue }
            
            coverArt.append(url)
        }
        
        let songs = try container.decode([Song].self, forKey: .songs)
        
        self.artist = artist
        self.name = name
        self.id = id
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
}

struct Song: Decodable {
    var name: String
    var duration: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case id
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
        
        enum DurationCodingKey: String, CodingKey {
            case duration
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKey.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        
        self.id = id
        self.name = name
        self.duration = duration
    }
}
