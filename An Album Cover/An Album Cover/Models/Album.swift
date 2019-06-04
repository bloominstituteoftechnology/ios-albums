//
//  Album.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

struct Album {
	let artist: String
	let coverArt: [URL]
	let genres: [String]
	let id: UUID
	let name: String
	let songs: [Song]
}
