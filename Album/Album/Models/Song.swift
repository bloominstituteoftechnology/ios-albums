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
    var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .dropLeading
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        let durationString = formatter.string(from: duration)
        return durationString ?? "00:00:00"
    }
    var id: UUID
    var name: String
    let debuggingSong: Bool = false
    
    init(id: UUID = UUID(),duration: TimeInterval, name: String) {
        self.id = id
        self.duration = duration
        self.name = name
    }
    
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
    
    static func durationToSeconds(_ from: String) -> TimeInterval {
        var seconds: Double = 0.0
        let time = from.components(separatedBy: ":")
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
        return seconds
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        if debuggingSong { print ("Song ID: \(id)")}
        let durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.SongDurationCodingKeys.self, forKey: .duration)
        let durationString = try (durationContainer.decode(String.self, forKey: .duration))
        duration = Song.durationToSeconds(durationString)
        if debuggingSong { print ("Song Duration: \(duration)")}
        let nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.SongNameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        if debuggingSong { print ("Song Name: \(name)") }
    }
    
    func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: SongCodingKeys.self)
            try container.encode(id, forKey: .id)
            var nameContainer = container.nestedContainer(keyedBy: SongCodingKeys.SongNameCodingKeys.self, forKey: .name)
            try nameContainer.encode(name, forKey: .title)
            var durationContainer = container.nestedContainer(keyedBy: SongCodingKeys.SongDurationCodingKeys.self, forKey: .duration)
            let durationString = self.durationString
            if debuggingSong { print ("Encoding Song Duration: \(String(describing: durationString))") }
            try durationContainer.encode(durationString, forKey: .duration)
            
        } catch {
            throw (error)
        }
        
    }
}

extension Song: CustomDebugStringConvertible {
    var debugDescription: String {
        var result: String = ""
//        var duration: TimeInterval
//        var id: UUID
//        var name: String
        result += "***Song***\n\n"
        result += "\tID: \(id)\n"
        result += "\tName: \(name)\n"
        result += "\tDuration (seconds): \(duration)\n"
        return result
    }
}
