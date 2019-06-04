//
//  AnAlbum.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

struct AnAlbum {
	var artist: String
	var coverArt: [URL]
	var genres: [String]
	let id: UUID
	var name: String
	var songs: [Song]
}
