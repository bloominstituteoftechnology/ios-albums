//
//  Song.swift
//  Albums
//
//  Created by Brian Rouse on 5/7/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
//

import Foundation

struct Song: Codable {
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
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongsKeys.self)
        
        // ID
        let id = try container.decode(String.self, forKey: .id)
        self.id = id
        
        // NAME
        let firstNameContainer = try container.nestedContainer(keyedBy: SongsKeys.NameKeys.self, forKey: .name)
        let title = try firstNameContainer.decode(String.self, forKey: .title)
        self.name = title
        
        // DURATION
        let firstDurationContainer = try container.nestedContainer(keyedBy: SongsKeys.DurationKeys.self, forKey: .duration)
        let duration = try firstDurationContainer.decode(String.self, forKey: .duration)
        self.duration = duration
    }
}

