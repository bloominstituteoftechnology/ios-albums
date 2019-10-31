//
//  Album.swift
//  Albums
//
//  Created by Bobby Keffury on 10/30/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    var artist: String
//    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist
//        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        
//        let coverArt = try container.decode([String : URL].self, forKey: .coverArt)
//        self.coverArt = coverArt.compactMap({  $0.value })
        
        self.genres = try container.decode([String].self, forKey: .genres)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        self.songs = try container.decode([Song].self, forKey: .songs)
         
    }
    
}




struct Song: Codable {
    
    var duration: String
    var id: String
    var name: String
    
    enum SongCodingKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    enum DurationCodingKeys: String, CodingKey {
        case duration
    }
    
    enum NameCodingKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationCodingKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
    }
    
}
