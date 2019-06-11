//
//  AlbumsRepresentation.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct AlbumsRepresentation: Codable {
	let uuid: String
	let album: Album
	
	init(album: Album, uuid: String = UUID().uuidString) {
		self.uuid = uuid
		self.album = album
	}
	
	enum CodingKeys: String, CodingKey {
		case uuid
		case album
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		uuid = try container.decode(String.self, forKey: .uuid)
		album = try container.decode(Album.self, forKey: .album)
		
	}
	
}
