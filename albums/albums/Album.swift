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
    var coverArt: [URL]
    var genres: [String]
    let id: String
    let name: String
    var songs: [Song]
    
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
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArts: [URL] = []
        while !coverArtContainer.isAtEnd {
            let coverArtURLsContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtString = try coverArtURLsContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: coverArtString) {
                coverArts.append(coverArtURL)
            }
        }
        coverArt = coverArts
        
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
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
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        id = try container.decode(String.self, forKey: .id)
        
    }
}
