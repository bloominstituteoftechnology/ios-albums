//
//  Album.swift
//  Albums
//
//  Created by Ivan Caldwell on 1/28/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

import Foundation


struct Album: Decodable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id, name: String
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
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
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        /*
         // This is the super long wait of doing it...
         // I have to make a container for the array of url string in coverArt array
         var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
         // Make an empty array to hold the coverArt URLs
         var coverArts: [URL] = []
         while !coverArtContainer.isAtEnd {
         // Make a constant to hold the string(URL)
         let coverArtString = try coverArtContainer.decode(String.self)
         // Convert the URL string into a URL type
         if let coverArtURL = URL(string: coverArtString) {
         coverArts.append(coverArtURL)
         }
         }
         coverArt = coverArts
         */
        
        coverArt = try container.decode([URL].self, forKey: .coverArt)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
    }
}

struct Song: Decodable {
    let duration: String
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
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
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.Duration.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.Name.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        
        
    }
}



















































