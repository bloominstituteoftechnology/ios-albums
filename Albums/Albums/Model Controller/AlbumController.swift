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
		
	}
	
	private (set) var baseUrl = URL(string: "https://albums-dc0ee.firebaseio.com/")!
	private (set) var albums: [Album] = []
}

/// Networking

extension AlbumController {
	func putAlbum(album: Album) {
		var request = URLRequest(url: baseUrl)
		request.httpMethod = "PUT"
		
		
		
		
	}
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
