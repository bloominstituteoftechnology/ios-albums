//
//  Album.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

/*

{
"artist" : "Weezer",
"coverArt" : [ {
"url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"},
		{"url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
} ],
"genres" : [ "Alternative" ],
"id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
"name" : "Weezer (The Blue Album)",
"songs" : [ {
	"duration" : {
	"duration" : "3:25"
	},
	"id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
	"name" : {
	"title" : "My Name Is Jonas"
	}
	},
*/


struct Album: Codable {
	let artist: String
	let name: String
	let coverArt: [String]
	let genres: [String]
	
	let songs: [Song]
	
	enum AlbumCodingKeys: String, CodingKey {
		case artist
		case name
		case coverArt
		case genres
		case songs
		
		enum CoverArtKeys: String, CodingKey {
			case url
		}
		
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
		
		artist = try container.decode(String.self, forKey: .artist)
		name = try container.decode(String.self, forKey: .name)
		genres = try container.decode([String].self, forKey: .genres)
		
		var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
		
		var urls: [String] = []
		
		while !coverArtContainer.isAtEnd {
			let CoverArtUrlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtKeys.self)
			let url = try CoverArtUrlContainer.decode(String.self, forKey: .url)
			urls.append(url)
		}

		coverArt = urls
		songs = try container.decode([Song].self, forKey: .songs)
	}
	
	func ecode(from encoder: Encoder) throws {
		var container = encoder.container(keyedBy: AlbumCodingKeys.self)
		
		try container.encode(artist, forKey: .artist)
		try container.encode(name, forKey: .name)
		try container.encode(genres, forKey: .genres)
		try container.encode(coverArt, forKey: .coverArt)
		
		var songContainer = container.nestedUnkeyedContainer(forKey: .songs)
		for song in songs {
			try songContainer.encode(song)
		}
		
	}
	
	
}
