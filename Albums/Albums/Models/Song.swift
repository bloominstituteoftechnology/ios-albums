//
//  Song.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct Song: Equatable {
    let duration: String
    let id: String
    let title: String
}

extension Song: Codable {
    enum SongCodingKeys: String, CodingKey {
        case duration, id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        
        let durationDict = try container.decode([String: String].self, forKey: .duration)
        duration = durationDict["duration"] ?? ""
        
        id = try container.decode(String.self, forKey: .id)
        
        let nameDict = try container.decode([String: String].self, forKey: .name)
        title = nameDict["title"] ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        
        try container.encode(["duration": duration], forKey: .duration)
        try container.encode(id, forKey: .id)
        try container.encode(["title": title], forKey: .name)
    }
}
