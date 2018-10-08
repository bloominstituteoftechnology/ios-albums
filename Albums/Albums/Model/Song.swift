//
//  Song.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Song: Decodable {
    var duration: String
    var id: String
    var name: String
    
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
    
    // DECODING
    init(from decoder: Decoder) throws {
        let songContainer = try decoder.container(keyedBy: SongKeys.self)
        let durationContainer = try songContainer.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        let id = try songContainer.decode(String.self, forKey: .id)
        let nameContainer = try songContainer.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        
        self.duration = duration
        self.id = id
        self.name = name
    }
}
