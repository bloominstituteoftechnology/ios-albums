//
//  Album.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Album: Codable {

	
	enum CodingKeys: String, CodingKey {
		case id
		case artist
		case name
		
		case genres
		case coverArt
		case songs
		
		
		enum CoverArtCodingKeys: String, CodingKey {
			case url
		}
		
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decode(String.self, forKey: .id)
		artist = try container.decode(String.self, forKey: .artist)
		name = try container.decode(String.self, forKey: .name)
		genres = try container.decode([String].self, forKey: .genres)
	
		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
		var coverArtStrings: [String] = []
		while  !coverArtContainer.isAtEnd {
			let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
			let str = try urlContainer.decode(String.self, forKey: .url)
			coverArtStrings.append(str)
		}

		coverArt = coverArtStrings.compactMap( {  URL(string: $0) })
		songs = try container.decode([Song].self, forKey: .songs)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(artist, forKey: .artist)
		try container.encode(name, forKey: .name)
		try container.encode(genres, forKey: .genres)

		var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
		for c in coverArt {
			var cContainer = coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
			try cContainer.encode(c, forKey: .url)
		}
		
		try container.encode(songs, forKey: .songs)
	}
	
	init(id: String = UUID().uuidString, artist: String, name: String, genres: [String], coverArt: [URL], songs: [Song] = []) {
		
		self.id = id
		self.name = name
		self.artist = artist
		self.genres = genres
		self.coverArt = coverArt
		
		self.songs = songs
		
		
	}
	
	let id: String
	let artist: String
	let name: String
	
	let genres: [String]
	let coverArt: [URL]
	let songs: [Song]
}
