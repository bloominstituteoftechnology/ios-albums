//
//  SongExtension.swift
//  Albums
//
//  Created by Lisa Sampson on 9/3/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

extension Song: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
        case songName = "name"
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum SongNameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let songNameContainer = try container.nestedContainer(keyedBy: CodingKeys.SongNameCodingKeys.self, forKey: .songName)
        let songName = try songNameContainer.decode(String.self, forKey: .title)
        
        
        self.id = id
        self.duration = duration
        self.songName = songName
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var songNameContainer = container.nestedContainer(keyedBy: CodingKeys.SongNameCodingKeys.self, forKey: .songName)
        try songNameContainer.encode(songName, forKey: .title)
        
    }
}
