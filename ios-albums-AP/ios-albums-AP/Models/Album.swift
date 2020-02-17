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

/// Main part of this project
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
    
    /// Regular init
    init(artist: String, coverArt: [URL], genres: [String], id: String = UUID().uuidString, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    /// Decode
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        var coverArtArray = [URL]()
        if container.contains(.coverArt) {
            var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
            while coverArtContainer.isAtEnd == false {
                let coverArtURLContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
                let url = try coverArtURLContainer.decode(URL.self, forKey: .url)
                coverArtArray.append(url)
            }
        }
        
        var songsArray = [Song]()
        if container.contains(.songs) {
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            
            while songsContainer.isAtEnd == false {
                let song = try songsContainer.decode(Song.self)
                songsArray.append(song)
            }
        }
        
        var genreArray = [String]()
        if container.contains(.genres) {
            var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
            
            while genresContainer.isAtEnd == false {
                let genre = try genresContainer.decode(String.self)
                genreArray.append(genre)
            }
            
        }
        
        coverArt = coverArtArray
        songs = songsArray
        genres = genreArray
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
    }
    
    /// Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
        for url in coverArt {
            try coverArtURLContainer.encode(url, forKey: .url)
        }
        
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
    
    /// Regular init
    init(name: String, id: String = UUID().uuidString, duration: String) {
           self.duration = duration
           self.id = id
           self.name = name
    }
     
    /// Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let durationDescriptionContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
            
        duration = try durationDescriptionContainer.decode(String.self, forKey: .duration)
            
        id = try container.decode(String.self, forKey: .id)
            
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
            
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    /// Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        var durationDescriptionContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .durationDescription)
        try durationDescriptionContainer.encode(duration, forKey: .duration)
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
}
