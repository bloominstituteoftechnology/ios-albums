//
//  Album.swift
//  Albums
//
//  Created by Jake Connerly on 9/30/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    
    enum AlbumKeys: String, CodingKey {
        case artist
    }
    
    init(decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
    }
}
