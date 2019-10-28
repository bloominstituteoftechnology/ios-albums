//
//  Album.swift
//  Albums
//
//  Created by macbook on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


struct Album: Codable {
    
    let name: String
    let artist: String
    let genres: [String]
    let coverURLs: [String]
    let songs: [Song]
    let songTitle: String
    let songDuration: String
    
    enum AlbumKeys: String, CodingKey {
        case name
        case artis
        case genres
        case coverURLs = "coverArt"
        case songTitle
        case songDuration
    }
    
    enum Song: String, CodingKey {
        case songTilte
    }
    
    // Making a custom decoder:
    init(from decoder: Decoder) throws {
        
        //telling the decoder that you want a dictionary that has AlbumKeys in it:
        //this entire initializer throws, so you have to try everything you do
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
    }
    
    
    
    
}
