//
//  Album.swift
//  Albums
//
//  Created by Sergey Osipyan on 1/28/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct Album: Codable {
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
        
        enum CoverArt: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtNames: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let covertArtUrlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArt.self)
            let url = try covertArtUrlContainer.decode(String.self, forKey: .url)
            if let urls = URL(string: url) {
            coverArtNames.append(urls)
        }
        }
        
        coverArt = coverArtNames
      //  coverArt = try container.decode([URL].self, forKey: .coverArt)
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
       
}
    


struct Song: Codable {
    let duration: String
    let id: String
    let name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum Duration: String, CodingKey {
            case duration
        }
        enum Name: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.Duration.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.Name.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
}
    func encode(to encoder: Encoder) throws {
        
        var albumContainer = encoder.container(keyedBy: AlbumKeys.self)
        try albumContainer.encode(artist, forKey: .artist)
        try albumContainer.encode(id, forKey: .id)
        try albumContainer.encode(name, forKey: .name)
        var coverArtContainer = albumContainer.nestedUnkeyedContainer(forKey: .coverArt)
        
       for art in coverArt {
            try coverArtContainer.encode(art.absoluteString)
            }
         try albumContainer.encode(genres, forKey: .genres)
        
        var songContainer = albumContainer.nestedUnkeyedContainer(forKey: .songs)
        for item in songs {
            try songContainer.encode(item.duration)
            try songContainer.encode(item.id)
            try songContainer.encode(item.name)
        }
        try albumContainer.encode(genres, forKey: .genres)
        
    }

}



