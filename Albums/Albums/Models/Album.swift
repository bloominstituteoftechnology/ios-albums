//
//  Album.swift
//  Albums
//
//  Created by Dahna on 5/7/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: URL
    let genres: [String]
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case songs
        
        init(from decoder: Decoder) throws {
            
        }
    }
}

struct Song: Codable {
    let name: String
    let duration: String
    let id: String
}

