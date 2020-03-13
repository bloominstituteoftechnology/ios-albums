//
//  Album.swift
//  Albums
//
//  Created by Gerardo Hernandez on 3/11/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let albumName: String
    
}

struct Song: Codable {
    let duration: String
    let title: String
    
}
