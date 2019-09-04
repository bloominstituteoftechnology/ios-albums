//
//  Song.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Song: Codable {
	let id: UUID
	let title: String
	let duration: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case duration
	}
	
	enum DurationKeys: String, CodingKey {
		case duration
	}
	
	enum NameKeys: String, CodingKey {
		case title
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let idString = try container.decode(String.self, forKey: .id)
		id = UUID(uuidString: idString) ?? UUID()
		
		let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
		title = try nameContainer.decode(String.self, forKey: .title)
		
		let durationContainer = try container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
		duration = try durationContainer.decode(String.self, forKey: .duration)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		
		var nameContainer = container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
		try nameContainer.encode(title, forKey: .title)
		
		var durationContainer = container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
		try durationContainer.encode(duration, forKey: .duration)
	}
}
