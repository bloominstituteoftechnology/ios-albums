//
//  Album.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

struct Album: Codable: Decodable {
    var id: UUID        // 5E58FA0F-7DBD-4F1D-956F-89756CF1EB22
    var artist: String  // Weezer
    var coverArt: [URL] // https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png
    var genres: [String] // Alternative
    var name: String    // Weezer (The Blue Album)
    var song: [Song]
}

struct Song: Decodable {
    var id: UUID
    var title: String
    var duration: String
}
