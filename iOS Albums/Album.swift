//
//  Album.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import Foundation

typealias CoverArtTuple = (size: String, url: URL)

class Album: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case coverArt
        case genres
        case songs
        case id
        
        enum CovertArtKeys: String, CodingKey {
            case url
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let artist = try container.decode(String.self, forKey: .artist)
        let identifier = try container.decode(UUID.self, forKey: .id)
        
        var coverArt: [URL] = []
        
        if container.contains(.coverArt) {
            
            var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while !coverArtArray.isAtEnd {
                let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: CodingKeys.CovertArtKeys.self)
                
                let url = try coverArtDictionary.decode(URL.self, forKey: .url)
                print("This is the url: \(url)")
                
                coverArt.append(url)
            }
        }
        
        var genres: [String] = []
        
        if container.contains(.genres) {
            
            var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
            
            
            while !genresContainer.isAtEnd {
                let genre = try genresContainer.decode(String.self)
                genres.append(genre)
            }
            
        }
        
        var songs: [Song] = []
        if container.contains(.songs) {
            
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            
            
            while !songsContainer.isAtEnd {
                let song = try songsContainer.decode(Song.self)
                
                songs.append(song)
            }
            
        }
        self.name = name
        self.artist = artist
        self.identifier = identifier
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(identifier, forKey: .id)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var urlContainer = coverArtContainer.nestedContainer(keyedBy: CodingKeys.CovertArtKeys.self)
        
        for url in coverArt {
            try urlContainer.encode(url, forKey: .url)
        }
        
        try container.encode(genres, forKey: .genres)
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        
        for song in songs {
            try songsContainer.encode(song)
        }
    }
    
    init(name: String, artist: String, identifier: UUID = UUID(), coverArt: [URL], genres: [String], songs: [Song]) {
        self.name = name
        self.artist = artist
        self.identifier = identifier
        self.coverArt = coverArt
        self.genres = genres
        self.songs = songs
    }
    
    var artist: String
    var name: String
    var identifier: UUID
    var coverArt: [URL]
    var genres: [String]
    var songs: [Song]
}


class Song: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case id
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
            case seconds
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    init(title: String, identifier: UUID = UUID(), duration: String) {
        self.title = title
        self.identifier = identifier
        self.duration = duration
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let identifier = try container.decode(UUID.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        
        let title = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        self.title = title
        self.duration = duration
        self.identifier = identifier
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(identifier, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        
        try nameContainer.encode(title, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        try durationContainer.encode(duration, forKey: .duration)
    }
    
    let title: String
    let identifier: UUID
    let duration: String
}






/*
 {
   "artist" : "Weezer",
   "coverArt" : [ {
     "url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
   } ],
   "genres" : [ "Alternative" ],
   "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
   "name" : "Weezer (The Blue Album)",
   "songs" : [ {
     "duration" : {
       "duration" : "3:25"
     },
     "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
     "name" : {
       "title" : "My Name Is Jonas"
     }
   }, {
     "duration" : {
       "duration" : "3:05"
     },
     "id" : "6E8AC92B-ABB4-4303-89CC-51020CEBB557",
     "name" : {
       "title" : "No One Else"
     }
   }, {
     "duration" : {
       "duration" : "4:19"
     },
     "id" : "0A856A54-2E15-4D4A-9B4B-1870F7783EBE",
     "name" : {
       "title" : "The World Has Turned And Left Me Here"
     }
   }, {
     "duration" : {
       "duration" : "2:39"
     },
     "id" : "7119F603-B37E-40B5-968D-E0091A610765",
     "name" : {
       "title" : "Buddy Holly"
     }
   }, {
     "duration" : {
       "duration" : "5:06"
     },
     "id" : "DDECE717-E075-4A64-9A9F-68CB2A5A58B6",
     "name" : {
       "title" : "Undone (The Sweater Song)"
     }
   }, {
     "duration" : {
       "duration" : "3:06"
     },
     "id" : "3FD6E647-4DF1-48CF-8E76-B932DF773ED3",
     "name" : {
       "title" : "Surf Wax America"
     }
   }, {
     "duration" : {
       "duration" : "4:17"
     },
     "id" : "214FB379-4032-4310-8B7C-C69BA21C4394",
     "name" : {
       "title" : "Say It Ain’t So"
     }
   }, {
     "duration" : {
       "duration" : "3:56"
     },
     "id" : "E4ECC640-120D-4A35-8938-3D83DE031430",
     "name" : {
       "title" : "In The Garage"
     }
   }, {
     "duration" : {
       "duration" : "3:25"
     },
     "id" : "34C44D53-6B14-40F7-8438-F147BD2B321D",
     "name" : {
       "title" : "Holiday"
     }
   }, {
     "duration" : {
       "duration" : "7:59"
     },
     "id" : "BA71E72D-E148-4D81-9A11-D7EA048F2949",
     "name" : {
       "title" : "Only In Dreams"
     }
   } ]
 }


 */
