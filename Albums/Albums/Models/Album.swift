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
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    enum CoverArtCodingKeys: String, CodingKey {
        case url
    }
    
//    init(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
//        self.artist = artist
//        self.coverArt = coverArt
//        self.genres = genres
//        self.id = id
//        self.name = name
//        self.songs = songs
//    }
    
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtContainer.isAtEnd {
            let coverArtDictionary = try coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
            let coverArtURL = try coverArtDictionary.decode(URL.self, forKey: .url)
            coverArt.append(coverArtURL)
        }
        
       
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        while !genresContainer.isAtEnd {
            let genreString = try genresContainer.decode(String.self)
            genres.append(genreString)
        }
        
        self.id = try container.decode(String.self, forKey: .id)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        while !songsContainer.isAtEnd {
            let songString = try songsContainer.decode(Song.self)
            songs.append(songString)
        }
         
        
             
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumCodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtDictionary = coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
        try coverArtDictionary.encode(coverArt, forKey: .url)
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        try genresContainer.encode(genres)
        
        try container.encode(name, forKey: .name)
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        try songsContainer.encode(songs)
        
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
    
    init(duration: String, id: String, name: String) {
        
        self.duration = duration
        self.id = id
        self.name = name
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: DurationCodingKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        
        var durationContainer = container.nestedContainer(keyedBy: DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
    
}
