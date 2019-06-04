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
"url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
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


struct Album: Decodable {
	let artist: String
	let name: String
	let coverArt: [String]
	let genres: [String]
	
	enum AlbumCodingKeys: String, CodingKey {
		case artist
		case name
		case coverArt
		case genres
		
		enum CoverArtKeys: String, CodingKey {
			case url
		}
		
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
		artist = try container.decode(String.self, forKey: .artist)
		name = try container.decode(String.self, forKey: .name)
		
	
//		let coverArtContainer = try container.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtKeys.self, forKey: .coverArt)
//		let ca = try coverArtContainer.decode(String.self, forKey: .url)
//

		
		coverArt = []
		genres = try container.decode([String].self, forKey: .genres)
		
	}
}
