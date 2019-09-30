//
//  Song.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class Song: Decodable {
    var duration: TimeInterval
    var id: UUID
    var name: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum SongDurationCodingKeys: String, CodingKey {
            case duration    
        }
        
        enum SongNameCodingKeys: String, CodingKey{
            case title
        }
    }
}
