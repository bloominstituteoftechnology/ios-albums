//
//  Album.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let albumTitle: String
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case albumTitle = "name"
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        albumTitle = try container.decode(String.self, forKey: .albumTitle)
        
        
        // coverArt
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        
        while coverArtContainer.isAtEnd == false {
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtString = try coverArtURLContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: coverArtString) {
                coverArtURLs.append(coverArtURL)
            }
        }
        
        coverArt = coverArtURLs
        
        let genresDict = try container.decode([Int : String].self, forKey: .genres)
        genres = genresDict.compactMap { $0.value }
        
        songs = try container.decode([Song].self, forKey: .songs)
        
//        while songsContainer.isAtEnd == false {
//            let songDurationContainer = try songsContainer.nestedContainer(keyedBy: )
//        }
        
//        let coverArtDict = try container.decode([String : String].self, forKey: .coverArtURLs)
//        coverArtURLs = coverArtDict.compactMap { URL(string: $0.value) }
        

//
//        let songsArray = try container.decode([Song].self, forKey: .songs)
        
    }
}

struct Song: Decodable {
    let duration: String
    let id: String
    let name: String
    
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
        
        id = try container.decode(String.self, forKey: .id)
        
        let songDurationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try songDurationContainer.decode(String.self, forKey: .duration)
        
        let songNameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try songNameContainer.decode(String.self, forKey: .title)
    }
}
