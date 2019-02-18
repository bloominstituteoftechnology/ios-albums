//
//  Song.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Song: Decodable {
    
    // MARK: - Properties
    var id: String
    var duration: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case id, duration, name
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    
     // MARK: - Codable
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        // Set the properties
        self.id = id
        self.duration = duration
        self.name = name
    }
    
}
