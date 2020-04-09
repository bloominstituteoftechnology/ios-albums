//
//  Album.swift
//  Albums
//
//  Created by Nichole Davidson on 4/9/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Album: Decodable {
    var artist: String
    var coverArt: [String]
    var url: String
    var genres: [String]
    var name: String
    var songs: [Song]
}

struct Song: Decodable {
    enum CodingKeys: String, CodingKey {
        case duration, id, name, title
    }
    var id: String
    var name: Title
    var duration: Duration
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(Title.self, forKey: .name)
        duration = try container.decode(Duration.self, forKey: .duration)
    }
    
}

struct Title: Decodable {
    var text: String
}

struct Duration: Decodable {
    var time: String
}
