//
//  Album.swift
//  Albums
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

struct Album: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case id, artist, coverArt, genres, songs
    }
    
    let title: String
    let artist: String
    let id: String
    let genres: [String]
    let coverArt: [URL]
    let songs: [Song]
}

struct Song: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case duration
        case id
    }
    
    let title: String
    let duration: String
    let id: String
    
    init(from decoder: Decoder) throws {
        
    }
}
