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
		//putAlbum(album: albums[0]) { _ in}
		
		
		print(albums.count)
	}
	
	private (set) var baseUrl = URL(string: "https://albums-dc0ee.firebaseio.com/")
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
	
	func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
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
				completion(.failure(error))
				return
			}
			
			
			guard let data = data else {
				NSLog("Error getting data)")
				completion(.failure(NSError()))
				return
			}

			do {
				let decoded = try JSONDecoder().decode([String: Album].self, from: data)
				completion(.success(Array(decoded.values)))
			} catch {
				NSLog("Error decoding albums: \(error)")
				completion(.failure(error))
				return
			}

		}.resume()
	}
	
	
	func putAlbum(album: Album, completion: @escaping (Error?) -> ()) {
		guard let baseUrl = baseUrl  else { return }
		
		let url = baseUrl.appendingPathComponent(album.id).appendingPathExtension("json")
		
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
			completion(nil)
		}.resume()
		
	}
}


