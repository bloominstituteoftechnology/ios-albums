//
//  Songs.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Songs: Codable {
    
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
    
    var duration: String
    var id: UUID
    var name: String
    
    init(duration: String, id: UUID = UUID(), name: String) {
        
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        id = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongKeys.self)
        
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}

let url = URL(string: "exampleAlbum.json")!
let data = try! Data(contentsOf: url)

let decoder = JSONDecoder()
let albumSongs = try! decoder.decode(Songs.self, from: data)

let encoder = JSONEncoder()
let songData = try! encoder.encode(albumSongs)
let dataAsString = String(data: songData, encoding: .utf8)!


