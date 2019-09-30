//
//  Songs.swift
//  Albums
//
//  Created by Percy Ngan on 9/30/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation


struct Songs: Decodable {
	let songs: [String]

	enum SongKeys: String, CodingKey {
		case duration
		case name
		case id

		enum DurationKeys: String, CodingKey {
			case duration
		}
		enum NameKeys: String, CodingKey {
			case title
		}




	}
}
