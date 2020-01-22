//
//  Song.swift
//  Album
//
//  Created by Christy Hicks on 1/21/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

// MARK: - Coding Keys
enum SongCodingKeys: String, CodingKey {
    case name
    case duration
    case id
    
    enum DurationCodingKeys: String, CodingKey {
        case duration
        case seconds
    }
    
    enum NameCodingKeys: String, CodingKey {
        case title
    }
}

class Song: Codable {
    // MARK: - Properties
    let title: String
    let identifier: UUID
    let duration: String

    // MARK: - Initializers
    init(title: String, identifier: UUID = UUID(), duration: String) {
        self.title = title
        self.identifier = identifier
        self.duration = duration
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        
        let identifier = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        
        let title = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        self.title = title
        self.duration = duration
        self.identifier = identifier
    }
    
    // MARK: - Methods
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        try container.encode(identifier, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(title, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
    }
}
