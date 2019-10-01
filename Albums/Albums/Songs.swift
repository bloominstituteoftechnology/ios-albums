//
//  Songs.swift
//  Albums
//
//  Created by Percy Ngan on 9/30/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation


struct Song: Decodable {
	let duration: String
	let id: String
	let name: String

	enum SongKeys: String, CodingKey {
		case duration
		case name
		case id // I don't think the id is needed

		enum DurationKeys: String, CodingKey {
			case duration
		}
		enum NameKeys: String, CodingKey {
			case title
		}
	}

	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: SongKeys.self)
		let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
		let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)

		duration = try durationContainer.decode(String.self, forKey: .duration)
		name = try nameContainer.decode(String.self, forKey: .title)
		id = try container.decode(String.self, forKey: .id)

	}
}
