//
//  Album.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum CodingKeys: String, CodingKey {
        case artist
        case name
        case genres
        case coverArt
        
    }
    
    
    
    var artist: String
    var name: String
    var genres: [String]
    var coverArt: [[String: String]]
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let genres = try container.decode([String].self, forKey: .genres)
        let artist = try container.decode(String.self, forKey: .artist)
        let name = try container.decode(String.self, forKey: .name)
        
        //var coverArt: [[String: String]] = []
        
        let coverArt = try container.decode([[String: String]].self, forKey: .coverArt)
        
        //coverArt.append(coverArts)
        
        self.artist = artist
        self.name = name
        self.genres = genres
        self.coverArt = coverArt
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        
        var genresContainer = container.nestedUnkeyedContainer(forKey: .genres)
        
        for genre in genres {
            try genresContainer.encode(genre)
        }
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for art in coverArt {
            try coverArtContainer.encode(art)
        }
    }
/* // Take all of the Person's properties and put them in the encoder object
 func encode(to encoder: Encoder) throws {
 
 var container = encoder.container(keyedBy: CodingKeys.self)
 
 try container.encode(name, forKey: .name)
 try container.encode("\(height)", forKey: .height)
 try container.encodeIfPresent(hairColor, forKey: .hairColor)
 
 var filmsContainer = container.nestedUnkeyedContainer(forKey: .films)
 
 for film in films {
 try filmsContainer.encode(film.absoluteString) // puts films back into string format
 }
 
 // The above and below examples do the same thing
 
 let starshipStrings = starships.map({ $0.absoluteString })
 try container.encode(starshipStrings, forKey: .starships)
 }*/
    
}


struct Song: Codable {
   
    enum CodingKeys: String, CodingKey {
        case songs
        enum SongsCodingKeys: String, CodingKey {
            case duration
            enum DurationCodingKeys: String, CodingKey {
                case duration
            }
            
            case name
            enum NameCodingKeys: String, CodingKey {
                case title
            }
            
        }
    }
    
    var songs: [String: String] //ability - name // duration - duration and name - title
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        var songs: [String: String] = [:]
        
        
        while !songsContainer.isAtEnd {
            
            let songContainer = try songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            
            let songTitleContainer = try songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.NameCodingKeys.self, forKey: .name)
            let songTitle = try songTitleContainer.decode(String.self, forKey: .title)
            
            let songDurationContainer = try songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.DurationCodingKeys.self, forKey: .duration)
            let durationTime = try songDurationContainer.decode(String.self, forKey: .duration)
            
            songs[songTitle] = durationTime
            
        }
        
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        
        for name in songs.keys {
            
            var songContainer = songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            
            var songTitleContainer = songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.NameCodingKeys.self, forKey: .name)
            
            try songTitleContainer.encode(name, forKey: .title)
        }
        
        for duration in songs.values {
            var songContainer = songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            
            var songDurationContainer = songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.DurationCodingKeys.self, forKey: .duration)
            
            try songDurationContainer.encode(duration, forKey: .duration)
        }
        
    }
    
    
}

/*struct CoverArt: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case coverArt
        enum ArtCodingKeys: String, CodingKey {
            case url
        }
        
    }
    
    var coverArt: [String: String]
}*/




