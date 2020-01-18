//
//  Album.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import Foundation

struct Song: Codable {
    let duration: String
    let id: String
    let name: String
    
    init(duration: String, id: String, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    enum SongCodingKey: String, CodingKey {
        case duration
        case id
        case name
    
    
    enum NameCodingKey: String, CodingKey {
        case title
    }
    
    enum DurationCodingKey: String, CodingKey {
        case duration
    }
}
    
    init(from decoder:Decoder) throws {
        let jsonKeyedContainer = try decoder.container(keyedBy: SongCodingKey.self)
        self.id = try jsonKeyedContainer.decode(String.self, forKey: SongCodingKey.id)
        
        let jsonDurationNestedContainer = try jsonKeyedContainer.nestedContainer(keyedBy: SongCodingKey.DurationCodingKey.self, forKey: .duration)
        self.duration = try jsonDurationNestedContainer.decode(String.self, forKey: SongCodingKey.DurationCodingKey.duration)
        
        let jsonNameNestedContainer = try jsonKeyedContainer.nestedContainer(keyedBy: SongCodingKey.NameCodingKey.self, forKey: .name)
        self.name = try jsonNameNestedContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var jsonKeyedContainer = try encoder.container(keyedBy: SongCodingKey.self)
        
        try jsonKeyedContainer.encode(id, forKey: .id)
        
        var jsonNameKeyedContainer = try jsonKeyedContainer.nestedContainer(keyedBy: SongCodingKey.NameCodingKey.self, forKey: .name)
        
        try jsonNameKeyedContainer.encode(name, forKey: .title)
        
        var durationNestedContainer = try jsonKeyedContainer.nestedContainer(keyedBy: SongCodingKey.DurationCodingKey.self, forKey: .duration)
        
        try durationNestedContainer.encode(duration, forKey: .duration)
    }
}



struct Album: Codable {
    
    let artist: String
    let coverArt: [URL]
    let id: String
    let genres: [String]
    let name: String
    var songs: [Song]
    
    
    init(artist: String, coverArt: [URL], id: String, genres: [String], name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.id = id
        self.genres = genres
        self.name = name
        self.songs = songs
    }
    
    
    enum AlbumCodingKey: String, CodingKey {
        
        case artist
        case coverArt
        case id
        case genres
        case name
        case songs
    }
    
    enum CoverArtCodingKey: String, CodingKey {
            case url
        }
    
    
        
        init(from decoder: Decoder)
            throws {
                let jsonContainer = try decoder.container(keyedBy: AlbumCodingKey.self)
                
                self.id = try jsonContainer.decode(String.self, forKey: .id)
                
                self.name = try jsonContainer.decode(String.self, forKey: .name)
                
                self.songs = try jsonContainer.decode([Song].self, forKey: .songs)
                
                self.artist = try jsonContainer.decode(String.self, forKey: .artist)
                
                self.genres = try jsonContainer.decode([String].self, forKey: .genres)
                
                var coverArtURLs: [URL] = []
                var coverArtContainer = try jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
                
                while !coverArtContainer.isAtEnd {
                    let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKey.self)
                    
                    let coverArtURLString = try urlContainer.decode(String.self, forKey: .url)
                    
                    if let url = URL(string: coverArtURLString) {
                        coverArtURLs.append(url)
                    }
                }
                
                self.coverArt = coverArtURLs
                
                var songs: [Song] = []
                var songContainer = try jsonContainer.nestedUnkeyedContainer(forKey: .songs)
                
                while !songContainer.isAtEnd {
                    let song = try songContainer.decode(Song.self)
                    
                    songs.append(song)
                }
                
                self.songs = songs
        }
        
        func encode(to encoder: Encoder) throws {
            var jsonEncodedContainer = encoder.container(keyedBy: AlbumCodingKey.self)
            
            try jsonEncodedContainer.encode(id, forKey: .id)
            
            try jsonEncodedContainer.encode(name, forKey: .name)
            
            try jsonEncodedContainer.encode(artist, forKey: .artist)
            
            try jsonEncodedContainer.encode(genres, forKey: .genres)
            
            var coverArtContainer = jsonEncodedContainer.nestedUnkeyedContainer(forKey: .coverArt)
            
            var urlContainer = coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKey.self)
            
            for url in coverArt {
                try urlContainer.encode(url.absoluteString, forKey: .url)
            }
            
            try jsonEncodedContainer.encode(songs, forKey: .songs)
        }
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
