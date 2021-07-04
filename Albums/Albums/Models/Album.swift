//
//  Album.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Album: Codable {
	let id: UUID
	var artist: String
	var coverArt: [URL]?
	var genres: [String]
	var title: String
	var songs: [Song]
	
	enum CodingKeys: String, CodingKey {
		case id
		case artist
		case coverArt
		case genres
		case title = "name"
		case songs
	}
	
	enum CoverArtKeys: String, CodingKey {
		case url
	}
	
	init(id: UUID?, artist: String, coverArt: [URL]?, genres: [String], title: String, songs: [Song]) {
		self.id = id ?? UUID()
		self.artist = artist
		self.coverArt = coverArt
		self.genres = genres
		self.title = title
		self.songs = songs
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		artist = try container.decode(String.self, forKey: .artist)
		genres = try container.decode([String].self, forKey: .genres)
		title = try container.decode(String.self, forKey: .title)
		songs = try container.decode([Song].self, forKey: .songs)
		
		let idString = try container.decode(String.self, forKey: .id)
		id = UUID(uuidString: idString) ?? UUID()
		
		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
		var urls = [URL]()
		while !coverArtContainer.isAtEnd {
			let urlContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtKeys.self)
			urls.append(try urlContainer.decode(URL.self, forKey: .url))
		}
		coverArt = urls
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		try container.encode(artist, forKey: .artist)
		try container.encode(genres, forKey: .genres)
		try container.encode(title, forKey: .title)
		try container.encode(songs, forKey: .songs)
		
		var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
		if let coverArt = coverArt {
			for url in coverArt {
				var urlContainer = coverArtContainer.nestedContainer(keyedBy: CoverArtKeys.self)
				try urlContainer.encode(url, forKey: .url)
			}
		}
	}
}
