//
//  Album.swift
//  albums
//
//  Created by Lambda_School_Loaner_34 on 2/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

struct Album: Decodable {
    var artist: String
    var name: String
    
    var genres: [Genres]
    var songs: [Song]
}

struct Genres: Decodable {
    var genre: String
}

struct Song: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case duration
        case name
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let duration = try container.decode(String.self, forKey: .duration)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(String.self, forKey: .id)
    
        self.duration = duration
        self.name = name
        self.id = id
    
        }

    let duration: String
    let name: String
    let id: String

}
