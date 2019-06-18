//
//  Song.swift
//  AlbumHWRepeat
//
//  Created by Michael Flowers on 6/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Song: Codable {
    //what do we want to grab from the json
    var duration: String
    let id: UUID //convert from string
    let name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        //because we have to drill down to get inside of the "{"
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        //because we have to drill down to get inside of the "{"
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        //this is the first {} container, not the array
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        //convert the string json into our uuid type // dont have to because uuid conforms to codable
        id = try container.decode(UUID.self, forKey: .id)
    
        //create a container for the "{" after duration
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        
        //now that we are inside the container we can decode to get the value
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        //create a container to get inside the "{" after the name
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        
        //now that we are inside of the { we can decode for the value
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        try container.encode(id.uuidString, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
