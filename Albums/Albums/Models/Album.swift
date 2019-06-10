//
//  Album.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Album: Decodable {
	let id: String
	let artist: String
	let name: String
	
//	let coverArt: [URL]
//	let genres: [String]
//	let songs: [Song]
	
	enum CodingKeys: String, CodingKey {
		case id
		case artist
		case name
		
//		case coverArt
//		case genres
//		case songs
		
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
		artist = try container.decode(String.self, forKey: .artist)
		name = try container.decode(String.self, forKey: .name)
	}
	
	
}
