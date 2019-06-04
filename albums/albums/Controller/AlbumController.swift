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
				self.parseAlbumJsonData(with: data)
			}
		}
	}
	
	private func parseAlbumJsonData(with data: Data) {
		let decoder = JSONDecoder()
		do {
			let albumsDecoded = try decoder.decode(Album.self, from: data)
			albums.append(albumsDecoded)
		} catch {
			NSLog("Error decoding json: \(error)")
		}
	}
	
	var albums: [Album] = []
}
