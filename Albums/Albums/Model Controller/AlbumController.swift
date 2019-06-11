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
		putAlbum(album: albums[0]) { error in
			if let error = error {
				print("error puting \(error)")
			}
		}
		print(albums.count)
	}
	
	private (set) var baseUrl = URL(string: "https://albums-dc0ee.firebaseio.com/")!
	private (set) var albums: [Album] = []
	private (set) var albumRep: [AlbumsRepresentation] = []
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
	func putAlbum(album: Album, completion: @escaping (Error?) -> ()) {
		let url = baseUrl.appendingPathComponent(UUID().uuidString).appendingPathExtension("json")
		
		var request = URLRequest(url: url)
		request.httpMethod = "PUT"
		
		do{
			request.httpBody  = try JSONEncoder().encode(album)
		
		} catch {
			NSLog("Error encoding Album: \(error)")
			completion(error)
		}
		
		URLSession.shared.dataTask(with: request) { _, response, error in
			if let response = response as? HTTPURLResponse {
				NSLog("putAlbum Response: \(response.statusCode)")
			}
			
			if let error = error {
				NSLog("Error puting Album: \(error)")
				completion(error)
				return
			}
			
		}.resume()
		
	}
}


