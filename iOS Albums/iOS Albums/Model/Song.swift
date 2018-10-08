//
//  Song.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Song: Codable {
    
    // MARK: - Properties
    var id: String
    var duration: String
    var name: String
    
    // Coding keys for encoding and decoding
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
    
    // MARK: - Initializers
    init (title: String, duration: String, id: String) {
        self.name = title
        self.duration = duration
        self.id = id
    }
    
    // MARK: - Codable
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the easy stuff
        let id = try container.decode(String.self, forKey: .id)
        
        // Pull the duration out of its object
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        // Pull the name out of its object
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        // Set the properties
        self.id = id
        self.duration = duration
        self.name = name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode the easy stuff
        try container.encode(id, forKey: .id)
        
        // Make an object for the duration and encode it
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        // Make an object for the name and encode it
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
    }
}
