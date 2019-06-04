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


	func createAlbum(artist: String, coverArtString: String, genres: String, id: UUID = UUID(), name: String, songs: [Song]) {
		let newAlbum = _createAlbum(artist: artist, coverArtString: coverArtString, genres: genres, id: id, name: name, songs: songs)
		albums.append(newAlbum)

		put(album: newAlbum) { (result: Result<AnAlbum, NetworkError>) in
			do {
				_ = try result.get()
			} catch {
				NSLog("There was an error: \(error)")
			}
		}
	}

	private func _createAlbum(artist: String, coverArtString: String, genres: String, id: UUID = UUID(), name: String, songs: [Song]) -> AnAlbum {
		var coverArtString = coverArtString
		coverArtString = coverArtString.replacingOccurrences(of: ",", with: " ")
		let coverArtStrings = coverArtString.split(separator: " ").map { String($0) }
		let coverArtURLs = coverArtStrings.compactMap{ URL(string: $0) }

		var genres = genres
		genres = genres.replacingOccurrences(of: ",", with: " ")
		let genresArray = genres.split(separator: " ").map { String($0) }

		let newAlbum = AnAlbum(artist: artist, coverArt: coverArtURLs, genres: genresArray, id: id, name: name, songs: songs)
		return newAlbum
	}


	func createSong(named name: String, duration: String, id: UUID = UUID()) -> Song {
		let song = Song(id: id, duration: duration, name: name)
		return song
	}

	func updateAlbum(album: AnAlbum, artist: String, coverArtString: String, genres: String, name: String, songs: [Song]) {
		guard let albumIndex = albums.firstIndex(of: album) else { return }
		let updatedAlbum = _createAlbum(artist: artist, coverArtString: coverArtString, genres: genres, id: album.id, name: name, songs: songs)
		albums[albumIndex] = updatedAlbum
		put(album: updatedAlbum) { (result: Result<AnAlbum, NetworkError>) in
			do {
				_ = try result.get()
			} catch {
				NSLog("There was an error: \(error)")
			}
		}
	}

	// MARK: - Netcode
	private let baseURL = URL(string: "https://lambda-school-mredig.firebaseio.com/anAlbumCover")!

	let networkHandler = NetworkHandler()

	func getAlbums(completion: @escaping (Result<[AnAlbum], NetworkError>) -> Void) {

		let request = baseURL.appendingPathExtension("json").request

		networkHandler.transferMahCodableDatas(with: request) { (result: Result<[String: AnAlbum], NetworkError>) in
			do {
				let albumDict = try result.get()
				let albums = Array(albumDict.values)
				self.albums = albums
				completion(.success(self.albums))
			} catch {
				completion(.failure(error as? NetworkError ?? NetworkError.otherError(error: error)))
			}
		}
	}

	func put(album: AnAlbum, completion: @escaping (Result<AnAlbum, NetworkError>) -> Void) {
		let putURL = baseURL.appendingPathComponent(album.id.uuidString).appendingPathExtension("json")
		var request = putURL.request
		request.httpMethod = HTTPMethods.put.rawValue

		let encoder = JSONEncoder()
		do {
			request.httpBody = try encoder.encode(album)
		} catch {
			completion(.failure(.dataCodingError(specifically: error)))
			return
		}

		networkHandler.transferMahCodableDatas(with: request, completion: completion)
	}
	
}


extension AnAlbumController {

	// MARK: - Testing
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
		put(album: albums[0]) { (result: Result<AnAlbum, NetworkError>) in
			print("done")
		}
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
