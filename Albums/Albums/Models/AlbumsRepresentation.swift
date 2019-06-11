//
//  AlbumsRepresentation.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct AlbumsRepresentation: Codable {
	let uuid: String
	let album: Album
	
	init(album: Album, uuid: String = UUID().uuidString) {
		self.uuid = uuid
		self.album = album
	}
}
