//
//  Album.swift
//  Albums
//
//  Created by Marlon Raskin on 9/3/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct Album: Decodable {
	let name: String
	let artist: String
	let genres: [String]
	let id: String

	enum AlbumCodingKeys: String, CodingKey {
		case artist
		case genres
		case id
	}
}

struct Song: Decodable {
	let duration: String
	let id: String
	let name: String

	enum SongCodingKeys: String, CodingKey {
		case duration
		case id
		case name
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: SongCodingKeys.self)

		id = try container.decode(String.self, forKey: .id)
		
		
	}
}


