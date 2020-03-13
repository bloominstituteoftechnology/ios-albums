//
//  Album.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import Foundation

struct Album {
    let artist: String // Single Value inside a keyed Container
//    var coverArt: [Dictionary<String, String>] = [] // unkeyed Container has "url" property as a Keyed container Value
//    var coverArt: [String] = [] // unkeyed Container has "url" property as a Keyed container Value
    var coverArt: [URL] = []
    let genres: [String] // unkeyed container
    let id: String // Single Value in a keyed container
    let name: String // Album name as a Single Value in a keyed container
    let songs: [Song] // an array (unkeyed container) of keyed containers with:
                      // duration (a keyed container with property "duration : ..."),
                      // id - a Single Value, and
                      // name (a keyed container with property "title : ...")
    
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

extension Album: Decodable {
    
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
}
