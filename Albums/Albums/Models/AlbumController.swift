//
//  AlbumController.swift
//  Albums
//
//  Created by Percy Ngan on 10/1/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

enum HTTPMethod: String {

	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"

}

class AlbumController {

	var albums: [String] = []

	func testDecodingExampleAlbum() {
		let decoder = JSONDecoder()
		let URL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
		if let URL = URL {
			do {
				let data = try Data(contentsOf: URL)
				let album = try decoder.decode(Album.self, from: data)
				albums.append(album)
				put(album:album) { (error) in
					if let error = error {
						NSLog("Error PUTing album: \(error)")
					}
				}

			} catch {

			}
		}
	}

	func testEncodingExampleAlbum() {
		let encoder = JSONEncoder()
		do {
			let data = try encoder.encode(albums)
			print (String(describing: data))
		} catch {
			NSLog("there is an error: \(error)")
		}
	}

	// Mark: - Networking API

	func put(album: Album, completion: @escaping () -> Void = { }) {

		let base = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")

//		let identifier = movie.identifier ?? UUID().uuidString
//		movie.identifier = identifier

		var request = URLRequest(url: base)
		request.httpMethod = HTTPMethod.put.rawValue

		guard let movieRepresentation = movie.movieRepresentation else {
			NSLog("Respresentation is nil")
			completion()
			return
		}

		do {
			request.httpBody = try JSONEncoder().encode(movieRepresentation)
		} catch {
			NSLog("Error encoding task representation: \(error)")
			completion()
			return
		}

		URLSession.shared.dataTask(with: request) { (_, _, error) in

			if let error = error {
				NSLog("Error PUTting task: \(error)")
				completion()
				return
			}

			completion()
			}.resume()
	}
}
