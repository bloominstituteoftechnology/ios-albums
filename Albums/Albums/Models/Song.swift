//
//  Songs.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Song: Codable {

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case duration
		
		enum NameCodingKeys: String, CodingKey {
			case title
		}
		
		enum DurationCodingKeys: String, CodingKey {
			case duration
		}
		
	}
	
	init (name: String, duration: String, id: String = UUID().uuidString) {
		self.name = name
		self.duration = duration
		self.id = id
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
		
		let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
		name = try nameContainer.decode(String.self, forKey: .title)
		
		let duarationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
		duration = try duarationContainer.decode(String.self, forKey: .duration)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		
		var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
		try nameContainer.encode(name, forKey: .title)
		
		var duarationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
		try duarationContainer.encode(duration, forKey: .duration)
	}
	
	let id: String
	let name: String
	let duration: String
	
}
