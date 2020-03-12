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
    var coverArt: [Dictionary<String, String>] = [] // unkeyed Container has "url" property as a Keyed container Value
    let genres: [String] // unkeyed container
    let id: String // Singel Value in a keyed container
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
        case name // keyed container
        case songs // unkeyed containter, containing keyed containers
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
        enum NameKeys: String, CodingKey {
            case title
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
            let coverArtURLS = try coverArtContainer.decode([Dictionary<String, String>].self, forKey: .url)
            coverArt = coverArtURLS
        }
        //coverArt = try jsonContainer.decode([String].self, forKey: .coverArt)
        
        genres = try jsonContainer.decode([String].self, forKey: .genres)
        id = try jsonContainer.decode(String.self, forKey: .id)
        
        let nameKeyedContainer = try jsonContainer.nestedContainer(keyedBy:
            AlbumTopLevelKeys.NameKeys.self, forKey: .name)
        
        name = try nameKeyedContainer.decode(String.self, forKey: .title)
        songs = try jsonContainer.decode([Song].self, forKey: .songs)
    }
}
