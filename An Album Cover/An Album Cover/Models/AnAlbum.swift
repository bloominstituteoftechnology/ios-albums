//
//  AnAlbum.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

struct AnAlbum: Decodable {
	var artist: String
	var coverArt: [URL]
	var genres: [String]
	let id: UUID
	var name: String
	var songs: [Song]

	enum CodingKeys: String, CodingKey {
		case artist
		case coverArt
		case genres
		case id
		case name
		case songs

		enum CoverArtKeys: String, CodingKey {
			case url
		}
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		artist = try container.decode(String.self, forKey: .artist)
		genres = try container.decode([String].self, forKey: .genres)
		let idStr = try container.decode(String.self, forKey: .id)
		guard let id = UUID(uuidString: idStr) else{ throw NSError() }
		self.id = id
		name = try container.decode(String.self, forKey: .name)

		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
		var urls = [URL]()
		while coverArtContainer.isAtEnd {
			let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtKeys.self)
			let url = try urlContainer.decode(URL.self, forKey: .url)
			urls.append(url)
		}
		coverArt = urls

		songs = try container.decode([Song].self, forKey: .songs)
	}
}
