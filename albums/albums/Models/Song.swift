//
//  Song.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

/*

"songs" : [ {
"duration" : {
"duration" : "3:25"
},
"id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
"name" : {
"title" : "My Name Is Jonas"
}
}

*/


struct Song: Codable {
	let id: String
	let name: String
	let duration: String
	
	init(id: String, name: String, duration: String) {
		self.id = id
		self.name = name
		self.duration = duration
	}
	
	
	enum SongCodingKeys: String, CodingKey {
		case id
		case name
		case duration
		
		enum NameSongCodingKeys: String, CodingKey {
			case title
		}
		
		enum CaseSongCodingKeys: String, CodingKey {
			case duration
		}
	}
	
	
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: SongCodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
		
		let nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameSongCodingKeys.self, forKey: .name)
		name = try nameContainer.decode(String.self, forKey: .title)
		
		let durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.CaseSongCodingKeys.self, forKey: .duration)
		duration = try durationContainer.decode(String.self, forKey: .duration)
		
	}
	
	func ecode(from encoder: Encoder) throws {
		var container = encoder.container(keyedBy: SongCodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(duration, forKey: .duration)
	}
	
}
