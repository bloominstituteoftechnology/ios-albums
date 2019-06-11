//
//  AlbumController.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class AlbumController {
	
	init() {
		fetchJsonDataFromBundle()
		putAlbum(album: albums[0])
		print(albums.count)
	}
	
	private (set) var baseUrl = URL(string: "https://albums-dc0ee.firebaseio.com/")!
	private (set) var albums: [Album] = []
}

extension AlbumController {
	
	func fetchJsonDataFromBundle() {
		if let fileUrl = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") {
			do {
				let data = try Data(contentsOf: fileUrl)
				let decode = try JSONDecoder().decode(Album.self, from: data)
				albums.append(decode)
			} catch {
				NSLog("Error Getting data: \(error)")
			}
			
			
		}
	}
}




/// Networking

extension AlbumController {
	func putAlbum(album: Album) {
		var request = URLRequest(url: baseUrl)
		request.httpMethod = "PUT"
		
		do{
			let encoded = try JSONEncoder().encode(album)
			request.httpBody = encoded
			
		} catch {
			NSLog("Error encoding Album: \(error)")
		}
		
		URLSession.shared.dataTask(with: request) { _, response, error in
			if let response = response as? HTTPURLResponse {
				NSLog("putAlbum Response: \(response.statusCode)")
			}
			
			if let error = error {
				NSLog("Error puting Album: \(error)")
			}
			
			
		}.resume()
		
	}
}


