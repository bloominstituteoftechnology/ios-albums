//
//  Album.swift
//  ios-Albums
//
//  Created by Jerrick Warren on 11/26/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation
import UIKit

class Album: Codable {
    
    var id: String
    var name: String
    var artist: String
    var coverArtURLs: [URL]
    var genres: [String]
    var songs: [Song] //
    
    // create coding key?
    enum CodingKeys: String, CodingKey {
        case id // this will automactially be "id" if I don't put a raw value
        case name
        case artist
        case coverArtURLs = "coverArt"
        case genres
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    // init
    init(name:String, artist: String, genres: [String], coverArtURLs: [URL]) {
        self.id =  UUID().uuidString
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArtURLs = coverArtURLs
        self.songs = []
        
    }
    
    // decodable
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let artist = try container.decode(String.self, forKey: .artist)
        let genres = try container.decode([String].self, forKey: .genres)
        
        // nested unKeyed containers
        var coverArtsContainer = try container.nestedUnkeyedContainer(forKey: .coverArtURLs)
        var coverArtURLStrings : [String] = []
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songs: [Song] = []
        
        while !coverArtsContainer.isAtEnd {
            let coverArtsContainer = try coverArtsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            let coverArtURLString = try coverArtsContainer.decode(String.self, forKey: .url)
            coverArtURLStrings.append(coverArtURLString)
        }
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        
        self.id = id
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArtURLs = coverArtURLs
        self.songs = songs
    }
    
    // encoder time :) - yay
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        
        var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArtURLs)
        
        for coverArtURL in coverArtURLs {
            var coverArtContainer = coverArtsContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            try coverArtContainer.encode(coverArtURL.absoluteString, forKey: .url)
        }
        
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
    }
}

struct Song: Codable {
    
    var id: String
    var name: String
    var duration: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case duration
        
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
   
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)

        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        
        self.id = id
        self.duration = duration
        self.name = name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
    }
}
