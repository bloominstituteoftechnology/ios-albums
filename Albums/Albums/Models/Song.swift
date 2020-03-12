//
//  Song.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import Foundation

struct Song {
    var id: String // Single Value
    var name: String // nested keyed container with a Single Value
    var duration: String // nested keyed Container with a single Value
    
    enum SongTopLevelKeys: String, CodingKey {
        case id
        case name
        case duration
        
        enum SongNameKeys: String, CodingKey {
            case title
        }
        
        enum SongDurationKeys: String, CodingKey {
            case duration
        }
    }
}

extension Song: Decodable {
    init(from decoder: Decoder) throws {
        
        let jsonContainer = try decoder.container(keyedBy: SongTopLevelKeys.self)
        
        id = try jsonContainer.decode(String.self, forKey: .id)
        
        let nameKeyedContainer = try jsonContainer.nestedContainer(keyedBy:
            SongTopLevelKeys.SongNameKeys.self, forKey: .name)
        
        name = try nameKeyedContainer.decode(String.self, forKey: .title)
        
        let durationKeyedContainer = try jsonContainer.nestedContainer(keyedBy:
            SongTopLevelKeys.SongDurationKeys.self, forKey: .duration)
        
        duration = try durationKeyedContainer.decode(String.self, forKey: .duration)
        
    }
}
