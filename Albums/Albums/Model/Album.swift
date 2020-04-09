//
//  Album.swift
//  Albums
//
//  Created by Nichole Davidson on 4/9/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let artist: String
    let coverArt: [String]
    let url: String
    let genres: [String]
    let name: String
    let songs: [Song]
}

struct Song: Decodable {
    enum CodingKeys: String, CodingKey {
        case duration, id, name, title
    }
    let id: String
    let name: Title
    let duration: Duration
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(Title.self, forKey: .name)
        duration = try container.decode(Duration.self, forKey: .duration)
    }
    
}

struct Title: Decodable {
    let text: String
}

struct Duration: Decodable {
    let time: String
}
