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
				print("Parse This:", data)
				
				self.parseAlbumJsonData(with: data)
			}
		}
	}
	
	func parseAlbumJsonData(with data: Data) {
		
		let decoder = JSONDecoder()
		
		do {
			let albums = try decoder.decode(Album.self, from: data)
			print(albums)
		} catch {
			NSLog("Error decoding json: \(error)")
		}
		
	}
	
	
}
