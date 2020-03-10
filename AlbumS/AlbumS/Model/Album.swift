//
//  Album.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

struct Album : Codable, Equatable {
    
    
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
            
        }
    }
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    init(artist:String,coverArt:[URL],genres:[String],id:String,name:String,songs:[Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
                artist = try container.decode(String.self, forKey: .artist)
                genres = try container.decode([String].self, forKey: .genres)
                id = try container.decode(String.self, forKey: .id)
                name = try container.decode(String.self, forKey: .name)
                songs = try container.decode([Song].self, forKey: .songs)
        
        
        var coverArt: [URL] = []
        
        if container.contains(.coverArt) {
            
            var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while !coverArtArray.isAtEnd {
                let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                let url = try coverArtDictionary.decode(URL.self, forKey: .url)
                
                coverArt.append(url)
            } }
        self.coverArt = coverArt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(artist, forKey: .artist)
        
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
       
        var coverArtArrayContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArtDictionaryContainer =  coverArtArrayContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
        for url in coverArt {
            try coverArtDictionaryContainer.encode(url, forKey: .url)
        }
       
    }

    

}


struct Song: Codable, Equatable {
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String,CodingKey {
            case duration
        }
        enum NameKeys: String,CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
    
    init(duration:String,id:String,name:String) {
        self.duration = duration
        self.id = id
        self.name = name 
    }
    
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
       let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
         id = try container.decode(String.self, forKey: .id)
     
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
    }
    
}
  

