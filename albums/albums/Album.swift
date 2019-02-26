//
//  Album.swift
//  albums
//
//  Created by Lambda_School_Loaner_34 on 2/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
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
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        
        while coverArtContainer.isAtEnd == false {
            let coverArtUURLsContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)//was missing this
            let coverArtString = try coverArtUURLsContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: coverArtString) {
                coverArtURLs.append(coverArtURL)
            }
        }
        coverArt = coverArtURLs
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
    }
}
struct Song: Decodable {
    let duration: String
    let name: String
    let id: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case name
        case id

        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: Song.SongKeys.DurationCodingKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: Song.SongKeys.NameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .name)
        
        id = try container.decode(String.self, forKey: .id)
        
    }
}
