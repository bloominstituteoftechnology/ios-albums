//
//  Album.swift
//  Albums
//
//  Created by Yvette Zhukovsky on 11/20/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit


//struct Album: Decodable {
//    var artist: String
//    var coverArt: [CoverArt]
//    var genres: [String]
//    var id: String
//    var name: String
//    var songs: [Songs]
//}
//struct CoverArt: Decodable {
//    var url: String
//}
//struct Songs: Decodable {
//    var duration: [Duration]
//    var id: String
//    var name:[Name]
//}
//struct Duration: Decodable {
//  var  duration: String
//}
//struct Name: Decodable {
//   var title: String 
//}


struct Album: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs

        enum CoverCodingKeys: String, CodingKey {
            case url
    }
}
    
    
    func encode(encoder:Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
     
        try container.encode(artist, forKey: .artist)
       try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
         try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)
        var coverContainer  = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for covers in coverArt {
            
            var containerCover = coverContainer.nestedContainer(keyedBy: CodingKeys.CoverCodingKeys.self)
            try containerCover.encode(covers, forKey: .url)
            
        }
    }
    
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        let name = try container.decode(String.self, forKey: .name)
        let genres = try container.decode([String].self, forKey: .genres)
        let id = try container.decode(String.self, forKey: .id)
        let songs = try container.decode([Songs].self, forKey: .songs)
        
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArt: [String] = []
        
        while !coverArtContainer.isAtEnd {
            
            let smallCoverArtContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverCodingKeys.self)
            let smallCoverArt = try smallCoverArtContainer.decode(String.self, forKey: .url)
            coverArt.append(smallCoverArt)
        }
        
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs

        
    }
    
    
    
    var coverArt:[String]
    var artist: String
    var name: String
    var genres: [String]
    var id: String
    var songs: [Songs]
}
   struct Songs: Codable {
        
        enum CodingKeys: String, CodingKey {
            case id
            case duration
            case songName = "name"
            
            enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum SongNameCodingKeys: String, CodingKey {
        case title
    }
    
}

    func encode(encoder:Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        var duratCotainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        try duratCotainer.encode(duration, forKey: .duration)
        var sNameContainer = container.nestedContainer(keyedBy: CodingKeys.SongNameCodingKeys.self, forKey: .songName)
        try sNameContainer.encode(songName, forKey: .title)
   
    }
    
    
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let durationCotainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationCotainer.decode(String.self, forKey: .duration)
        let songNameContainer = try container.nestedContainer(keyedBy: CodingKeys.SongNameCodingKeys.self, forKey: .songName)
        
        let songName = try songNameContainer.decode(String.self, forKey: .title)
        
        
        self.id = id
        self.duration = duration
        self.songName = songName
        

    }
    
 
    var id: String
    var duration: String
    var songName: String

}
