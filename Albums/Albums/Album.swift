//
//  Album.swift
//  Albums
//
//  Created by Percy Ngan on 9/30/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation


struct Album: Codable {
	let name: String
	let artist: String
	let genres: [String]
	let coverArt: [URL]
	let songs: [Song]

	enum AlbumKeys: String, CodingKey {
		case name
		case artist
		case genres
		case coverArt
		case songs
	}

	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: AlbumKeys.self)

		name = try container.decode(String.self, forKey: .name)
		artist = try container.decode(String.self, forKey: .artist)

		var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
		var genreNames: [String] = []
		while !genreContainer.isAtEnd {
			let genreString = try genreContainer.decode(String.self)
			genreNames.append(genreString)
		}
		genres = genreNames

		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
		var coverArtUrl: [URL] = []
		while !coverArtContainer.isAtEnd {
			let coverArtString = try coverArtContainer.decode(String.self)
			if let url = URL(string: coverArtString) {
				coverArtUrl.append(url)
			}
		}
		coverArt = coverArtUrl

		songs = try container.decode([Song], forKey: .songs)
	}
}

