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
//	let duration: String
//	let name: String
	
	enum SongCodingKeys: String,CodingKey {
		case id
	
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: SongCodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
	}
	
	
}
