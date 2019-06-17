//
//  Album.swift
//  AlbumHWRepeat
//
//  Created by Michael Flowers on 6/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: [URL] //convert from string to url
    let genres: [String]
    let id: UUID //convert from string to uuid
    let name: String
    let songs: [Song]
    
}
