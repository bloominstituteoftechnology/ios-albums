//
//  AlbumController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class AlbumController {
	
	
	func getJsonFileData() {
		if let jsonURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
			if let data = try? Data(contentsOf: jsonURL) {
				print("Parse This", data)
			}
		}
	}
	
}
