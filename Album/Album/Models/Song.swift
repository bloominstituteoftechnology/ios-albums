//
//  Song.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class Song: Decodable {
    var duration: TimeInterval
    var id: UUID
    var name: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum SongDurationCodingKeys: String, CodingKey {
            case duration    
        }
        
        enum SongNameCodingKeys: String, CodingKey{
            case title
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        let durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.SongDurationCodingKeys.self, forKey: .duration)
        let durationString = try (durationContainer.decode(String.self, forKey: .duration))
        var seconds: Double = 0.0
        let time = durationString.components(separatedBy: ":")
        for component in time.count - 1...0 {
            switch component {
            case 0: //Seconds
                seconds += Double(time[component]) ?? 0.0
            case 1:
                seconds += (Double(time[component]) ?? 0.0) * 60
            case 2:
                seconds += ((Double(time[component]) ?? 0.0) * 60) * 60
            default:
                break
            }
        }
        duration = seconds
        let nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.SongNameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
}
