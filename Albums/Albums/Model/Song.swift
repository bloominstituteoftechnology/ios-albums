//
//  Song.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Song: Decodable {
    var duration: String
    var id: UUID
    var title: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case title
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
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .title)
        title = try nameContainer.decode(String.self, forKey: .title)
    }
}
