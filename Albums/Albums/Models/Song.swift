//
//  Songs.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Song: Codable {
	let id: String
	let name: String
	let duration: String
	
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
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
		
		let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
		name = try nameContainer.decode(String.self, forKey: .title)
		
		let duarationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
		duration = try duarationContainer.decode(String.self, forKey: .duration)
	}
	
}
