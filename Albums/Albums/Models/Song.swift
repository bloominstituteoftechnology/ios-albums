//
//  Song.swift
//  Albums
//
//  Created by Jake Connerly on 9/30/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct Song: Decodable {
    let name: String
    let id: String
    let duration: String
    
    enum SongsKeys: String, CodingKey {
        case name
        case id
        case duration
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
    }
}
