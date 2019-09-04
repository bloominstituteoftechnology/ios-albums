//
//  Album.swift
//  Albums
//
//  Created by Marlon Raskin on 9/3/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct Album: Codable {
	var artist: String
	var coverArt: [URL]
	var genres: [String]
	var id: String
	var name: String
	var songs: [Song]

	enum AlbumsKeys: String, CodingKey {
		case artist
		case coverArt
		case genres
		case id
		case name
		case songs
	}

	enum CoverArtKeys: String, CodingKey {
		case url
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: AlbumsKeys.self)
		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)

		artist = try container.decode(String.self, forKey: .artist)
		genres = try container.decode([String].self, forKey: .genres)
		id = try container.decode(String.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		songs = try container.decode([Song].self, forKey: .songs)

		var urls: [URL] = []

		while !coverArtContainer.isAtEnd {
			let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtKeys.self)
			let url = try urlContainer.decode(URL.self, forKey: .url)
			urls.append(url)
		}
		coverArt = urls
	}
}


struct Song: Codable {
	var duration: String
	var id: String
	var name: String

	enum SongKeys: String, CodingKey {
		case duration
		case id
		case name
	}

	enum DurationKeys: String, CodingKey {
		case duration
	}

	enum NameKeys: String, CodingKey {
		case title
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: SongKeys.self)
		let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
		let durationContainer = try container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)

		id = try container.decode(String.self, forKey: .id)
		duration = try durationContainer.decode(String.self, forKey: .duration)
		name = try nameContainer.decode(String.self, forKey: .title)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: SongKeys.self)
		var durationContainer = container.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
		var nameContainer = container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)

		try durationContainer.encode(duration, forKey: .duration)
		try nameContainer.encode(name, forKey: .title)
		try container.encode(id, forKey: .id)
	}
}


