//
//  Songs.swift
//  Albums
//
//  Created by Sameera Roussi on 6/11/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import Foundation

struct Song: Decodable {
    let duration:  String
    let id: String
    let name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKey: String, CodingKey {
            case duration
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    } // SongKey
    
    init(from decoder: Decoder) throws {
        // Create the container
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        // Decode the duration
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        // Decode the id
        id = try container.decode(String.self, forKey: .id)
        
        // Decode the name
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    

    
    

    
}
