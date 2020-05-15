//
//  Album.swift
//  ios-albums
//
//  Created by Rob Vance on 5/14/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import Foundation

struct Album {
    var artist: String // single value in keyed container
    var genres: [String] // unkeyed container
    var coverArt: [URL] = []
    var id: String // single value in keyed container
    var name: String // Album name as a single value in a keyed container
    var songs: [Song] // array unkeyed container of keyed containers 
    
    
    enum AlbumTopLevelKeys: String, CodingKey {
        case artist
        case coverArt // unkeyed container with keyed container inside
        case genres // unkeyed container
        case id
        case name
        case songs // unkeyed containter, containing keyed containers
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }
}

extension Album: Codable {
    
    init(from decoder: Decoder) throws {
        let jsonContainer = try decoder.container(keyedBy: AlbumTopLevelKeys.self)
        
        artist = try jsonContainer.decode(String.self, forKey: .artist)
        
        var coverArtUnkeyedContainer = try jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
        while !coverArtUnkeyedContainer.isAtEnd {
            let coverArtContainer = try coverArtUnkeyedContainer.nestedContainer(keyedBy: AlbumTopLevelKeys.CoverArtKeys.self)
            //            let coverArtURLS = try coverArtContainer.decode([Dictionary<String, String>].self, forKey: .url)
            //            let coverArtURLS = try coverArtContainer.decode([String].self, forKey: .url)
            let coverArtURLS = try coverArtContainer.decode(URL.self, forKey: .url)
            coverArt.append(coverArtURLS)
        }
        
        genres = try jsonContainer.decode([String].self, forKey: .genres)
        id = try jsonContainer.decode(String.self, forKey: .id)
        name = try jsonContainer.decode(String.self, forKey: .name)
        songs = try jsonContainer.decode([Song].self, forKey: .songs)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var jsonContainer = encoder.container(keyedBy: AlbumTopLevelKeys.self)
        
        try! jsonContainer.encode(artist, forKey: .artist)
        
        let coverArtStrings = coverArt.map { $0.absoluteString }
        
        var coverArtContainer = jsonContainer.nestedUnkeyedContainer(forKey: .coverArt)
        
        for art in coverArtStrings {
            
            var urlContainer = coverArtContainer.nestedContainer(keyedBy: AlbumTopLevelKeys.CoverArtKeys.self)
            
            
            try urlContainer.encode(art, forKey: .url)
        }
        
        try! jsonContainer.encode(coverArtStrings, forKey: .coverArt)
        try! jsonContainer.encode(genres, forKey: .genres)
        try! jsonContainer.encode(id, forKey: .id)
        try! jsonContainer.encode(name, forKey: .name)
        try! jsonContainer.encode(songs, forKey: .songs)
        
    }
}

extension Album: Equatable {
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id
    }
}

