//
//  Album.swift
//  albums
//
//  Created by Lambda_School_Loaner_34 on 2/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case artist
        case coverArt
        case name
        case genres
        case songs
    }
    
    let artist: String
    let coverArt: [URL]
    let name: String
    let id: String
    let genres: [Genres]
    let songs: [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKeys: .artist)
        
        let name = try container.decode(String.self, forKeys: .name)
    
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genres: [Genres] = []
        
        
    
    self.artist = artist
    self.name = name
    self.genres = genres
    self.songs = songs
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
