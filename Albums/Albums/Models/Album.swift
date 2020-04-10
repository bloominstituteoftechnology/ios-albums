//
//  Album.swift
//  Albums
//
//  Created by Bling Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

struct Album {
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

struct Song {
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case duration
        case id
    }
    
    let title: String
    let duration: String
    let id: String
}
