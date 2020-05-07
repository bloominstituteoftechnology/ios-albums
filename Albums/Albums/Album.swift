//
//  Album.swift
//  Albums
//
//  Created by Kelson Hartle on 5/6/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation


struct Album : Decodable{
    var artist: String
    var coverArt: [URL]
    var genre: String
    
    
    
}
struct Song : Decodable {
    var name: String
    var songs: [String]
    var duration: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case songs
        case duration
        
        enum SongKeys: String, CodingKey {
            case duration
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        
        
    }
    
}

let decoder = JSONDecoder()


