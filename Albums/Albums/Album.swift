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
        enum CoverArt: String, CodingKey {
            case url
        }
    }
    
    init(feom decoder: Decoder) throws {
        
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
        genres = try container.decode([String].self, forKey: .genres)
        songs = [try Song.init(from: Song.SongKeys.self as! Decoder)]
    
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
        
        enum Duration: String, CodingKey {
            case duration
        }
        enum Name: String, CodingKey {
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.Duration.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.Name.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .name)
    }
    
}




