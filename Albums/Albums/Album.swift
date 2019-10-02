//
//  Album.swift
//  Albums
//
//  Created by Percy Ngan on 9/30/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation


struct Album: Codable {
	let id: String
	let name: String
	let artist: String
	var genres: [String]
	let coverArt: URL
	let songs: [Song]

	enum AlbumKeys: String, CodingKey {
		case id
		case name
		case artist
		case genres
		case coverArt
		case songs

		enum CoverArtCodingKeys: String, CodingKey {
			case url
		}
	}



	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: AlbumKeys.self)

		id = try container.decode(String.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		artist = try container.decode(String.self, forKey: .artist)

		var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
		var genreNames: [String] = []
		while !genreContainer.isAtEnd {
			let genreString = try genreContainer.decode(String.self)
			genreNames.append(genreString)
		}
		genres = genreNames
		genres = try container.decode([String].self, forKey: .genres)

		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
		let urlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtCodingKeys.self)
		var coverArtUrl: [URL] = []
		while !coverArtContainer.isAtEnd {
			let coverArtString = try coverArtContainer.decode(String.self)
			if let url = URL(string: coverArtString) {
				coverArtUrl.append(url)
			}
		}
		coverArt = try urlContainer.decode(URL.self, forKey: .url)

		songs = try container.decode([Song].self, forKey: .songs)
	}

	func encode(encoder: Encoder) throws {

		var container = encoder.container(keyedBy: AlbumKeys.self)
		var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
		var urlContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtCodingKeys.self)
		try container.encode(artist, forKey: .artist)
		try urlContainer.encode(coverArt.absoluteString, forKey: .url)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(songs, forKey: .songs)
		try container.encode(genres, forKey: .genres)

	}
}

