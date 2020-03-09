//
//  Album.swift
//  iOS-Albums
//
//  Created by Lambda_School_Loaner_268 on 3/9/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

public let decoder = JSONDecoder()
public let encoder = JSONEncoder()


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
    
    enum CoverArtKey: String, CodingKey {
        case url
    }
}
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        // final place
        var coverArtURLs: [URL] = []
        
        // Array that hold Dict
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        // loop through coverArtContainer
        while !coverArtContainer.isAtEnd {
            // Dict of URLs
            let urlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
            // Gets url in String form from the dictionary of urls
            let coverArtURLString = try urlContainer.decode(String.self, forKey: .url)
            // unwrap the coverArtURLString
            if let url = URL(string: coverArtURLString) {
                coverArtURLs.append(url)
            }
        }
        
        coverArt = coverArtURLs
        
        var songs: [Song] = []
        
        var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        while !songContainer.isAtEnd {
            let song = try songContainer.decode(Song.self)
            songs.append(song)
            
        }
        self.songs = songs 
    }
    
    func encode(to encoder: Encoder) throws {
        // Dictionary of "Album"
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        // Parent Array of Cover Art to be added to
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        // Dict of urls in parent array - Needed because there is no CoverArt obj
        var URLsDict = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKey.self)
        // check each url in coverart
        for url in coverArt {
            try URLsDict.encode(url, forKey: .url)
        }
        // Array of Song objects
        var songContainer = container.nestedUnkeyedContainer(forKey: .songs)
        // for every song in the submitted setip
        for song in songs {
            try songContainer.encode(song)
        }
        
    }
}

struct Song: Codable {
    
    var duration: String
    var id: String
    var name: String
    
    // Keys for Song dict
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum NameKeys: String, CodingKey {
            case title
        }
        
        // keys for Duration dict
        enum DurationKeys: String, CodingKey {
            case duration
            }
        // keys for Name dict
        
    }
    
    init(from decoder: Decoder) throws {
        // Array of Dicts
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        // Pull ID out of parent array
        id = try container.decode(String.self, forKey: .id)
        
        // Dict for Duration
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        
        // Pull duration string out of the duration dict
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        // Dict for Name
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        
        // Pull name string out of the Name dict
        name = try nameContainer.decode(String.self, forKey: .title)
        
    }
    
    func encode(to encoder: Encoder) throws {
            // Dictionary of "Album"
            var container = encoder.container(keyedBy: SongKeys.self)
            // Encode id into Dict
            try container.encode(id, forKey: .id)
            // nested DICT of names
            var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
            // encode title into nameContainer
            try nameContainer.encode(name, forKey: .title)
            // nest dict of Durations
            var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
            // encode duration into DurationContainer
            try container.encode(duration, forKey: .duration)
            
       }
    
}
