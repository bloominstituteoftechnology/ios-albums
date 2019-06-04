//
//  Song.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

struct Song: Equatable {
	let id: UUID
	let duration: String
	let name: String

	enum CodingKeys: String, CodingKey {
		case id
		case duration
		case name

		enum DurationKeys: String, CodingKey {
			case duration
		}

		enum NameKeys: String, CodingKey {
			case title
		}
	}

}

extension Song: Codable {

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let idStr = try container.decode(String.self, forKey: .id)
		guard let tID = UUID(uuidString: idStr) else { throw NSError() }
		id = tID

		let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
		duration = try durationContainer.decode(String.self, forKey: .duration)

		let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
		name = try nameContainer.decode(String.self, forKey: .title)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(id.uuidString, forKey: .id)
		var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationKeys.self, forKey: .duration)
		try durationContainer.encode(duration, forKey: .duration)

		var nameContainer = container.nestedContainer(keyedBy: CodingKeys.NameKeys.self, forKey: .name)
		try nameContainer.encode(name, forKey: .title)
	}
}
