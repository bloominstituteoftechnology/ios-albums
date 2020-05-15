//
//  Song.swift
//  ios-albums
//
//  Created by Rob Vance on 5/14/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import Foundation

struct Song {
    var id: String
    var name: String
    var duration: String
    
    enum SongTopLevelKeys: String, CodingKey {
        case id
        case name
        case duration
        
        enum SongNameKeys: String, CodingKey {
            case title
        }
        enum SongDurationKeys: String, CodingKey {
            case duration
        }
    }
}
extension Song: Codable {
    init(from decoder: Decoder) throws {

        let jsonContainer = try decoder.container(keyedBy: SongTopLevelKeys.self)

        id = try jsonContainer.decode(String.self, forKey: .id)

        let nameKeyedContainer = try jsonContainer.nestedContainer(keyedBy:
            SongTopLevelKeys.SongNameKeys.self, forKey: .name)

        name = try nameKeyedContainer.decode(String.self, forKey: .title)

        let durationKeyedContainer = try jsonContainer.nestedContainer(keyedBy:
            SongTopLevelKeys.SongDurationKeys.self, forKey: .duration)

        duration = try durationKeyedContainer.decode(String.self, forKey: .duration)

    }
}
