//
//  Album.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [CoverArtURL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
}
    
extension Album {
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum GenreContentKeys: String, CodingKey {
            case genre
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        coverArt = try coverArtContainer.decode([CoverArtURL].self)
        
        var genresNames: [String] = []
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        while !genresContainer.isAtEnd {
            let genreContentContainer = try genresContainer.nestedContainer(keyedBy: AlbumKeys.GenreContentKeys.self)
            let genreName = try genreContentContainer.decode(String.self, forKey: .genre)
            genresNames.append(genreName)
        }
        genres = genresNames
        
        id = try container.decode(String.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        songs = try songsContainer.decode([Song].self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(coverArt, forKey: .coverArt)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
    }
}

struct CoverArtURL: Codable {
    var url: String
}

extension CoverArtURL {
    enum CoverArtKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoverArtKeys.self)
        url = try container.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CoverArtKeys.self)
        try container.encode(url, forKey: .url)
    }
}

struct Song: Codable {
    var duration: SongDuration
    var id: String
    var name: SongName
}
 
extension Song {
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        name = try container.decode(SongName.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        duration = try container.decode(SongDuration.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(duration, forKey: .duration)
    }
}

struct SongDuration: Codable {
    var duration: String
}

struct SongName: Codable {
    var title: String
}

extension SongDuration {
    enum SongDurationKeys: String, CodingKey {
        case duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongDurationKeys.self)
        duration = try container.decode(String.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongDurationKeys.self)
        try container.encode(duration, forKey: .duration)
    }
}

extension SongName {
    enum SongNameKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongNameKeys.self)
        title = try container.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongNameKeys.self)
        try container.encode(title, forKey: .title)
    }
}
