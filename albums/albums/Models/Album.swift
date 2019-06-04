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


struct Album: Codable {
	let artist: String
	let name: String
	
	//	let coverArt:
//	let generes: [String]
//	let songs: [Song]
	
}
