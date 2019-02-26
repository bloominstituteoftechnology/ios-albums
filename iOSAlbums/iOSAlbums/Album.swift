//
//  Album.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
        
    }
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        
        var urlContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var artURLs: [URL] = []
        
        while !urlContainer.isAtEnd {
            let artContainer = try urlContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            
            let artURLString = try artContainer.decode(String.self, forKey: .url)
            let artURL = URL(string: artURLString)
            artURLs.append(artURL!)
        }
        
//        let coverArtStrings = try container.decode([String].self, forKey: .coverArt)
//        var coverArtURLs: [URL] = []
//        for art in coverArtStrings {
//            guard let coverArtURL = URL(string: art) else { continue }
//            coverArtURLs.append(coverArtURL)
//        }
        
        let genre = try container.decode([String].self, forKey: .genres)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let name = try container.decode(String.self, forKey: .name)
        
        let songs = try container.decode([Song].self, forKey: .songs)
        
        self.artist = artist
        self.coverArt = artURLs
        self.genres = genre
        self.id = id
        self.name = name
        self.songs = songs
    }
}

struct Song: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
    }
    
    var name: String
    var duration: String
    var id: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let id = try container.decode(String.self, forKey: .id)
        
        self.name = name
        self.duration = duration
        self.id = id
    }
}

//struct Duration: Equatable {
//    let duration: String
//}
//
//struct Name: Equatable {
//    let title: String
//}
