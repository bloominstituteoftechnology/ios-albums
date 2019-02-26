//
//  Album.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class Album: Codable {
    var artist: String
    var coverArt: URL?
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]?
    
    init(artist: String, coverArt: URL? = nil, genres: [String], id: String = UUID().uuidString, name: String, songs: [Song]? = nil) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist, coverArt, genres, id, name, songs
    }
    
    enum CoverArtCodingKeys: String, CodingKey {
        case url
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let genres = try container.decode([String].self, forKey: .genres)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        let coverArtObjectContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
        
        let coverArtString = try coverArtObjectContainer.decodeIfPresent(String.self, forKey: .url)
        let coverArtURL = URL(string: coverArtString!) ?? nil
        
        let songs = try container.decodeIfPresent([Song].self, forKey: .songs)
        
        self.artist = artist
        self.coverArt = coverArtURL
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtObjectContainer = coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
        
        try coverArtObjectContainer.encode(coverArt?.absoluteString ?? "", forKey: .url)
    }
}

struct Song: Codable {
    var duration: String
    var id: String
    var name: String
    
    init(duration: String, id: String = UUID().uuidString, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    enum SongCodingKeys: String, CodingKey {
        case duration, id, name
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
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
