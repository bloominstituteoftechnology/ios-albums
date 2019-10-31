//
//  Song.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Song: Codable {
    var duration: String
    var id: UUID
    var title: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationKeys: String, CodingKey {
        case duration
    }
    
    enum NameKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        /* JSON
         {
             "duration" : {
                "duration": "3:25"
             },
             "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
             "name" : {
                "title" : "My Name is Jonas"
             }
         }
         */
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
                
        id = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        title = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        var durationContainer = container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        try container.encode(id.uuidString, forKey: .id)
        var nameContainer = container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        try nameContainer.encode(title, forKey: .title)
    }
}
