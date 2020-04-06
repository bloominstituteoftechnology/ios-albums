//
//  Album.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation


struct Album: Decodable {
    
    // MARK: - Enums
    
    enum AlbumCodey: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        
        enum CoverArtsyCodey: String, CodingKey {
            case url
        }
        
    }
    
    // MARK: - Properties
    
    let artist: String
    let coverArt : [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodey.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        self.songs = try container.decode([Song].self, forKey: .songs)
        
        self.genres = try container.decode([String].self, forKey: .genres)
        
        var urlContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverURLs: [String] = []
        
        while !urlContainer.isAtEnd {
            let urlStringContainer = try urlContainer.nestedContainer(keyedBy: AlbumCodey.CoverArtsyCodey.self)
            let urlString = try urlStringContainer.decode(String.self, forKey: .url)
            coverURLs.append(urlString)
        }
        
        self.coverArt = coverURLs.compactMap { URL(string: $0) }
        
    }
    
}

// MARK: - Sub property models

struct Song: Decodable {
    
    enum SongyCodey: String, CodingKey {
        case duration
        case id
        case name
        
        enum SongDurationKey: String, CodingKey {
            case duration
        }
        
        enum SongTitleKey: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id : String
    let title: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongyCodey.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongyCodey.SongDurationKey.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongyCodey.SongTitleKey.self, forKey: .name)
        self.title = try nameContainer.decode(String.self, forKey: .title)
    }
    
}

