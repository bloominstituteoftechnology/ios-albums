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
    let coverArt: URL // keyed Container has "url" property as a Single Value
    let genres: [String] // unkeyed container
    let id: String // Singel Value in a keyed container
    let name: String // Album name as a Single Value in a keyed container
    let songs: [Song] // an array (unkeyed container) of keyed containers with:
                      // duration (a keyed container with property "duration : ..."),
                      // id - a Single Value, and
                      // name (a keyed container with property "title : ...")
}
