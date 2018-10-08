//
//  Song.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Song: Codable {
    var id: String
    var duration: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
        case name
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        self.id = id
        self.duration = duration
        self.name = name
    }
}
