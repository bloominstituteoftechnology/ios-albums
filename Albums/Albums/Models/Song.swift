//
//  Song.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

struct Song {
    
    // MARK: - Properties
    
    var title: String
    var duration: String
    var identifier: UUID
}

// MARK: - Coding Keys

extension Song {
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
}

extension Song: Codable {
    
    // MARK: - Decoder

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        // Decode identifier
        self.identifier = try container.decode(UUID.self, forKey: .id)
        
        // Decode title
        let nameDictionary = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        self.title = try nameDictionary.decode(String.self, forKey: .title)
        
        // Decode duration
        let durationDictionary = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        self.duration = try durationDictionary.decode(String.self, forKey: .duration)
    }
    
    // MARK: - Encoder

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        // Encode identifier
        try! container.encode(self.identifier, forKey: .id)
        
        // Encode title
        var nameDictionary = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try! nameDictionary.encode(self.title, forKey: .title)
        
        // Encode duration
        var durationDictionary = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try! durationDictionary.encode(self.duration, forKey: .duration)
    }
}
