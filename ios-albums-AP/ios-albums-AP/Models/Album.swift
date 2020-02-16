//
//  Album.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation


    
/* Album JSON
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
 }...
 */

/* Song JSON
[... {
  "duration" : {
    "duration" : "3:25"
  },
  "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
  "name" : {
    "title" : "My Name Is Jonas"
  }
} ...]
*/

struct Album: Codable {
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
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
    
    // DECODE
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArtArray = [URL]()
        
        while coverArtContainer.isAtEnd == false {
            let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let url = try coverArtURLContainer.decode(URL.self, forKey: .url)
            coverArtArray.append(url)
        }
        
        coverArt = coverArtArray
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
    }
    
    // ENCODE
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        let coverArtURLStrings = coverArt.map {
            value in value.absoluteString
        }
        try container.encode(coverArtURLStrings, forKey: .coverArt)
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs {
            try songsContainer.encode(song)
        }
    }
}

struct Song: Codable {
    
    var duration: String
    var id: String
    var name: String
        
    enum SongKeys: String, CodingKey {
        case durationDescription = "duration"
        case id
        case name
                
        enum DurationKeys: String, CodingKey {
            case duration
        }
            
        enum NameKeys: String, CodingKey {
            case title
        }
    }
     
    // DECODE
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationDescriptionContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
            
        duration = try durationDescriptionContainer.decode(String.self, forKey: .duration)
            
        id = try container.decode(String.self, forKey: .id)
            
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
            
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    // ENCODE
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        var durationDescriptionContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
        try durationDescriptionContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}

    
    
    // My original
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: AlbumKeys.self)
//
//        // artist
//        artist = try container.decode(String.self, forKey: .artist)
//
//        // coverArt
//        coverArt = try container.decode([URL].self, forKey: .coverArt)
//
//        // genres
//        genres = try container.decode([String].self, forKey: .genres)
//
//        // id
//        id = try container.decode(String.self, forKey: .id)
//
//        // name
//        name = try container.decode(String.self, forKey: .name)
//
//        // songs
//        songs = try container.decode([Song].self, forKey: .songs)
//
//    }

// Example JSON
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


 struct Album: Codable {
     var artist: String
     var coverArt: [URL]
     var genres: [String]
     var id: String
     var name: String
     var songs: [Song]
     
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
     
     init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: AlbumKeys.self)
         
         artist = try container.decode(String.self, forKey: .artist)
         
         var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
         
         var coverArtArray = [URL]()
         
         while coverArtContainer.isAtEnd == false {
             let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
             let url = try coverArtURLContainer.decode(URL.self, forKey: .url)
             coverArtArray.append(url)
         }
         
         coverArt = coverArtArray
         genres = try container.decode([String].self, forKey: .genres)
         id = try container.decode(String.self, forKey: .id)
         name = try container.decode(String.self, forKey: .name)
         songs = try container.decode([Song].self, forKey: .songs)
     }
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: AlbumKeys.self)
         
         try container.encode(artist, forKey: .artist)
         try container.encode(genres, forKey: .genres)
         try container.encode(id, forKey: .id)
         try container.encode(name, forKey: .name)
         let coverArtURLStrings = coverArt.map {
             value in value.absoluteString
         }
         try container.encode(coverArtURLStrings, forKey: .coverArt)
         var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
         for song in songs {
             try songsContainer.encode(song)
         }
     }
 }
 struct Song: Codable {
     var duration: String
     var id: String
     var name: String
         
     enum SongKeys: String, CodingKey {
         case durationDescription = "duration"
         case id
         case name
                 
         enum DurationKeys: String, CodingKey {
             case duration
                 
         }
             
         enum NameKeys: String, CodingKey {
             case title
         }
     }
         
     init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: SongKeys.self)
         
         let durationDescriptionContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
             
         duration = try durationDescriptionContainer.decode(String.self, forKey: .duration)
             
         id = try container.decode(String.self, forKey: .id)
             
         let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
             
         name = try nameContainer.decode(String.self, forKey: .title)
     }
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: SongKeys.self)
         
         var durationDescriptionContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
         try durationDescriptionContainer.encode(duration, forKey: .duration)
         
         var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
         try nameContainer.encode(name, forKey: .title)
     }
 }

 
 CC chat
 
 required init(from decoder: Decoder) throws {
   let container = try decoder.container(keyedBy: CodingKeys.self)
   let name = try container.decode(String.self, forKey: .name)
   let artist = try container.decode(String.self, forKey: .artist)
   let identifier = try container.decode(UUID.self, forKey: .id)
   var coverArt: [URL] = []
    
   if container.contains(.coverArt) {
     var coverArtArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
     while !coverArtArray.isAtEnd {
       let coverArtDictionary = try coverArtArray.nestedContainer(keyedBy: CodingKeys.CoverArtKeys.self)
        
       let url = try coverArtDictionary.decode(URL.self, forKey: .url)
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
 
 
 */
