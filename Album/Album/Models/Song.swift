//
//  Song.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import Foundation

class Song: Codable {
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
        print ("Song ID: \(id)")
        let durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.SongDurationCodingKeys.self, forKey: .duration)
        let durationString = try (durationContainer.decode(String.self, forKey: .duration))
        var seconds: Double = 0.0
        let time = durationString.components(separatedBy: ":")
        let range = (0...time.count - 1)
        for component in range.reversed() {
            switch component {
            case 0: //Seconds
                seconds += Double(time[component]) ?? 0.0
            case 1: //Minutes
                seconds += (Double(time[component]) ?? 0.0) * 60
            case 2: //Hours
                seconds += ((Double(time[component]) ?? 0.0) * 60) * 60
            default:
                break
            }
        }
        duration = seconds
        print ("Song Duration: \(duration)")
        let nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.SongNameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        print ("Song Name: \(name)")
    }
    
    func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: SongCodingKeys.self)
            try container.encode(id, forKey: .id)
            var nameContainer = container.nestedContainer(keyedBy: SongCodingKeys.SongNameCodingKeys.self, forKey: .name)
            try nameContainer.encode(name, forKey: .title)
            var durationContainer = container.nestedContainer(keyedBy: SongCodingKeys.SongDurationCodingKeys.self, forKey: .duration)
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.allowedUnits = [.second, .minute, .hour]
            let durationString = formatter.string(from: duration)
            print ("Encoding Song Duration: \(String(describing: durationString))")
            try durationContainer.encode(durationString, forKey: .duration)
            
        } catch {
            throw (error)
        }
        
    }
}
