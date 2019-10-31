//
//  Album.swift
//  iOS Albums
//
//  Created by Dillon P on 10/30/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation

struct Song: Decodable {
    let name: String
    let duration: String
    let id: UUID
    
    enum SongKeys: String, CodingKey {
        case name
        case duration
        case id
    }
    
    enum SongNameKeys: String, CodingKey {
        case title
    }
    
    enum SongDurationKeys: String, CodingKey {
        case duration
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let uuid = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: uuid)!
        
        let nameContainer = try container.nestedContainer(keyedBy: SongNameKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongDurationKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
    }
    
    
}

struct Album: Decodable, CodingKey {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: UUID
    let name: String
    let songs: [Song]
}
