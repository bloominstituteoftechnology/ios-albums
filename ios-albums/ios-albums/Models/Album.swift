//
//  Album.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import Foundation
/*
 { // keyed container
 "artist" : "Weezer", // single value
 "coverArt" : [ { //unkeyed container with keyed container
 "url" : // single value "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
 } ],
 "genres" : [ "Alternative" ], //unkeyed
 "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
 "name" : "Weezer (The Blue Album)",
 "songs" : [ { //unkeyed -> keyed -> keyed
 // first value of unkeyed container
 "duration" : {
 "duration" : "3:25"
 },
 "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
 "name" : {
 "title" : "My Name Is Jonas"
 }
 }, {
 // second value of unkeyed container
 "duration" : {
 "duration" : "3:05"
 },
 "id" : "6E8AC92B-ABB4-4303-89CC-51020CEBB557",
 "name" : {
 "title" : "No One Else"
 }
 }, {
 // third value of unkeyed container
 "duration" : {
 "duration" : "4:19"
 },
 "id" : "0A856A54-2E15-4D4A-9B4B-1870F7783EBE",
 "name" : {
 "title" : "The World Has Turned And Left Me Here"
 }
 }, {
 // fourth value of unkeyed container
 "duration" : {
 "duration" : "2:39"
 },
 "id" : "7119F603-B37E-40B5-968D-E0091A610765",
 "name" : {
 "title" : "Buddy Holly"
 }
 }, {
 // fith value of unkeyed container
 "duration" : {
 "duration" : "5:06"
 },
 "id" : "DDECE717-E075-4A64-9A9F-68CB2A5A58B6",
 "name" : {
 "title" : "Undone (The Sweater Song)"
 }
 }, {
 // sixth value of unkeyed container
 "duration" : {
 "duration" : "3:06"
 },
 "id" : "3FD6E647-4DF1-48CF-8E76-B932DF773ED3",
 "name" : {
 "title" : "Surf Wax America"
 }
 }, {
 // seventh value of unkeyed container
 "duration" : {
 "duration" : "4:17"
 },
 "id" : "214FB379-4032-4310-8B7C-C69BA21C4394",
 "name" : {
 "title" : "Say It Ain’t So"
 }
 }, {
 // eighth value of unkeyed container
 "duration" : {
 "duration" : "3:56"
 },
 "id" : "E4ECC640-120D-4A35-8938-3D83DE031430",
 "name" : {
 "title" : "In The Garage"
 }
 }, {
 // nineth value of unkeyed container
 "duration" : {
 "duration" : "3:25"
 },
 "id" : "34C44D53-6B14-40F7-8438-F147BD2B321D",
 "name" : {
 "title" : "Holiday"
 }
 }, {
 // tenth value of unkeyed container
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


struct Album {
//    static func == (lhs: Album, rhs: Album) -> Bool {
//        <#code#>
//    }
    
    
    var artist: String
    var coverArt: String
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
        
        enum CoverArtCodingKey: String, CodingKey {
            case url
        }
    }
}

extension Album: Codable {

    
    init(from decoder: Decoder) throws {
        let jsonConatiner = try decoder.container(keyedBy: AlbumCodingKeys.self)
        artist = try jsonConatiner.decode(String.self, forKey: .artist)
        id = try jsonConatiner.decode(String.self, forKey: .id)
        name = try jsonConatiner.decode(String.self, forKey: .name)
        genres = try jsonConatiner.decode([String].self, forKey: .genres)
        songs = try jsonConatiner.decode([Song].self, forKey: .songs)
        var coverArtContainer = try jsonConatiner.nestedUnkeyedContainer(forKey: .coverArt)
        let coverArtURLConatiner = try coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKey.self)
        coverArt = try coverArtURLConatiner.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var jsonContainer = encoder.container(keyedBy: AlbumCodingKeys.self)
        try jsonContainer.encode(artist, forKey: .artist)
        try jsonContainer.encode(id, forKey: .id)
        try jsonContainer.encode(name, forKey: .name)
        try jsonContainer.encode(genres, forKey: .genres)
        try jsonContainer.encode(songs, forKey: .songs)
        var coverArtContainer = jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLConatiner = coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKey.self)
        try coverArtURLConatiner.encode(coverArt, forKey: .url)
    }
}


struct Song {
    var duration: String
    var id: String
    var name: String
    
    enum SongCodingKeys: String, CodingKey {
        
        case duration
        case id
        case name
        
        enum DurationCodingKey: String, CodingKey {
            case duration
        }
        enum NameCodingKey: String, CodingKey {
            case title
        }
    }
}

extension Song: Codable {
    init(from decoder: Decoder) throws {
        let jsonContainer = try decoder.container(keyedBy: SongCodingKeys.self)
        id = try jsonContainer.decode(String.self, forKey: .id)
        let durationContainer = try jsonContainer.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKey.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        let nameContainer = try jsonContainer.nestedContainer(keyedBy: SongCodingKeys.NameCodingKey.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var jsonContainer = encoder.container(keyedBy: SongCodingKeys.self)
        try jsonContainer.encode(id, forKey: .id)
        var durationContainer = jsonContainer.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKey.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        var nameConatiner = jsonContainer.nestedContainer(keyedBy: SongCodingKeys.NameCodingKey.self, forKey: .name)
        try nameConatiner.encode(name, forKey: .title)
        
        
        
    }
}
