//
//  AlbumController.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case badURL
	case noToken
	case noData
	case notDecoding
	case notEncoding
	case other(Error)
}

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

typealias resultHandler = (Result<Bool, NetworkError>) -> Void

class AlbumController {
	
	private var albums = [Album]()
	var albumsByArtist: [String:[Album]] {
		return Dictionary(grouping: albums, by: {$0.artist})
	}
	
	let baseURL = URL(string: "https://santana-discography.firebaseio.com/")!
	
	//MARK: - Helpers
	
	func findAlbum(by indexPath: IndexPath) -> Album? {
		let sectionKey = Array(albumsByArtist.keys)[indexPath.section]
		let album = albumsByArtist[sectionKey]?[indexPath.row]
		return album
	}
	
	//MARK: - CRUD
	
	func getAlbums(completion: @escaping resultHandler) {
		let requestUrl = baseURL.appendingPathExtension("json")
		
		URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				self.albums = try JSONDecoder().decode([String:Album].self, from: data).compactMap({$0.value})
				completion(.success(true))
			} catch {
				completion(.failure(.notDecoding))
			}
			}.resume()
	}
	
	func putAlbum(_ newAlbum: Album, completion: @escaping resultHandler) {
		let requestURL = baseURL.appendingPathComponent(newAlbum.id.uuidString)
			.appendingPathExtension("json")
		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.put.rawValue
		
		do {
			let albumData = try JSONEncoder().encode(newAlbum)
			request.httpBody = albumData
		} catch {
			completion(.failure(.notEncoding))
		}
		
		URLSession.shared.dataTask(with: request) { (_, _, error) in
			if let error = error {
				completion(.failure(.other(error)))
			}
			completion(.success(true))
			}.resume()
	}
	
//	func testDecodingExampleAlbum() {
//		guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
//		do {
//			let data = try Data(contentsOf: filePath)
//			let decoder = JSONDecoder()
//			let testAlbum = try decoder.decode(Album.self, from: data)
//			albums.append(testAlbum)
//			print(albums)
//		} catch {
//			NSLog("Error decoding: \(error)")
//		}
//	}
//
//	func testEncodingExampleAlbum() {
//		guard let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
//		do {
//			let data = try Data(contentsOf: filePath)
//			let decodedData = try JSONDecoder().decode(Album.self, from: data)
//			let encodedData = try JSONEncoder().encode(decodedData)
//			let albumString = String(data: encodedData, encoding: .utf8)!
//			print(albumString)
//		} catch {
//			NSLog("Error encoding: \(error)")
//		}
//	}
}

