//
//  Album.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArtURLs: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist, coverArt, genres, id, name, songs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs = [URL]()
        
        while !coverArtContainer.isAtEnd {
            let coverArtURLDict = try coverArtContainer.decode([String: URL].self)
            coverArtURLs.append(contentsOf: coverArtURLDict.values)
        }
        
        self.coverArtURLs = coverArtURLs
    }
    
}

struct Song: Decodable {
    let duration: String
    let id: String
    let title: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration, id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        
        let durationDict = try container.decode([String: String].self, forKey: .duration)
        duration = durationDict["duration"] ?? ""
        
        id = try container.decode(String.self, forKey: .id)
        
        let nameDict = try container.decode([String: String].self, forKey: .name)
        title = nameDict["title"] ?? ""
    }
}
