//
//  Album.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

struct Album: Codable {
    
    var artist: String
    var name: String
    var id: String
    var coverArt: [URL]
    var genres: [String]
    var songs: [Song]
    
}

struct Song: Codable {
    var name: String
    var duration: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case id
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
        
        enum DurationCodingKey: String, CodingKey {
            case duration
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKey.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)

        
        self.id = id
        self.name = name
        self.duration = duration
    }
}
