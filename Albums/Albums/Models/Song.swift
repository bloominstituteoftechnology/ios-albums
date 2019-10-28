//
//  Song.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Song: Decodable {
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
    }
    
    let duration: String
    let id: UUID
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
    }
}
