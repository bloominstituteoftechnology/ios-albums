//
//  AnAlbumController.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

class AnAlbumController {
	var albums: [AnAlbum] = []

	func testDecodingExampleAlbum() {
		guard let fileURL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
		do {
			let data = try Data(contentsOf: fileURL)
			let decoder = JSONDecoder()
			let album = try decoder.decode(AnAlbum.self, from: data)
			albums.append(album)
		} catch {
			NSLog("there was an error: \(error)")
		}

		print("\(albums)\n\n")
	}

	func testEncodingExampleAlbum() {
		guard let album = albums.first else { return }

		let encoder = JSONEncoder()
		var data: Data?
		do {
			data = try encoder.encode(album)
		} catch {
			NSLog("there was an error: \(error)")
		}

		let string = String(data: data!, encoding: .utf8)!//cheating i know, but its jsut testing!
		print("\(string)\n\n")

		do {
			let decoder = JSONDecoder()
			let album = try decoder.decode(AnAlbum.self, from: data!) //cheating i know, but its jsut testing!
			albums.append(album)
		} catch {
			NSLog("there was an error: \(error)")
		}

	}
}
