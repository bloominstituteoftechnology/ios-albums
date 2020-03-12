//
//  Song.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

struct Song {
    var duration: String
    var id: String
    var title: String
    
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
    
    init(from decoder: Decoder) throws {
        let jsonContainer = try decoder.container(keyedBy: SongKeys.self)
        
        let durationKeyedContainer = try jsonContainer.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        
        let nameKeyedContainer = try jsonContainer.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        
        self.duration = try durationKeyedContainer.decode(String.self, forKey: .duration)
        self.id = try jsonContainer.decode(String.self, forKey: .id)
        self.title = try nameKeyedContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var jsonContainer = encoder.container(keyedBy: SongKeys.self)
        
        var durationKeyedContainer = jsonContainer.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
               
        var nameKeyedContainer = jsonContainer.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        
        try! jsonContainer.encode(self.id, forKey: .id)
        try! durationKeyedContainer.encode(self.duration, forKey: .duration)
        try! nameKeyedContainer.encode(self.title, forKey: .title)
    }
}
