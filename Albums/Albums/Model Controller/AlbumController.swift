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


//		putAlbum(album: AlbumsRepresentation(album: albums[0])) { error in
//			if let error = error {
//				print(error)
//			}
//		}
		
		getAlbums{ error in
			if let error = error {
				print("Error geting album: " , error)
			}
		}
		print(albums.count)
	}
	
	private (set) var baseUrl = URL(string: "https://albums-dc0ee.firebaseio.com/")
	private (set) var albums: [Album] = []
	private (set) var albumReps: [AlbumsRepresentation] = []
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
	
	func getAlbums(completion: @escaping (Error?) -> Void) {
		guard let baseUrl = baseUrl else { return }
		let url = baseUrl.appendingPathExtension("json")
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let response = response as? HTTPURLResponse {
				NSLog("Response code for getting albums: \(response.statusCode)")
			}
			
			if let error = error {
				NSLog("Error getting albums: \(error)")
				completion(error)
				return
			}
			
			
			guard let data = data else {
				NSLog("Error getting data)")
				completion(NSError())
				return
			}

			do {
				let decoded = try JSONDecoder().decode([String: Album].self, from: data)
				let value = Array(decoded.values)
				print(value)
			} catch {
				NSLog("Error decoding albums: \(error)")
				completion(error)
				return
			}
			
			
		}.resume()
		
		
	}
	
	
	func putAlbum(album: AlbumsRepresentation, completion: @escaping (Error?) -> ()) {
		guard let baseUrl = baseUrl else { return }
		let url = baseUrl.appendingPathComponent(album.uuid).appendingPathExtension("json")
		
		var request = URLRequest(url: url)
		request.httpMethod = "PUT"
		
		do{
			request.httpBody  = try JSONEncoder().encode(album.album)
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
			completion(nil)
		}.resume()
		
	}
}


