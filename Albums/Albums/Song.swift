//
//  Song.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Song: Codable {
    var id: String
    var name: String
    var duration: String // - TODO: make duration Int in seconds
    
    init(name: String, duration: String) {
        self.name = name
        self.duration = duration
        self.id = UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case duration
        
        enum DurationKey: String, CodingKey {
            case duration
        }
        
        enum NameKey: String, CodingKey {
            case title
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKey.self, forKey: .name)
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKey.self, forKey: .duration)
        
        id = try container.decode(String.self, forKey: .id)
        name = try nameContainer.decode(String.self, forKey: .title)
        duration = try durationContainer.decode(String.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameKey.self, forKey: .name)
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationKey.self, forKey: .duration)
        
        try container.encode(id, forKey: .id)
        try nameContainer.encode(name, forKey: .title)
        try durationContainer.encode(duration, forKey: .duration)
    }
}
