//
//  AlbumController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class AlbumController {
	func testDecodingExampleAlbum() {
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
			//print(albumsDecoded)
		} catch {
			NSLog("Error decoding json: \(error)")
		}
	}
	
	func testEncodingExampleAlbum(album: Album) {
		let plistEncoder = PropertyListEncoder()
		plistEncoder.outputFormat = .xml
		do {
			let plistData = try plistEncoder.encode(album)
			print(plistData)
			if let str = String(data: plistData, encoding: .utf8) {
				print("testEncodingExampleAlbum->>>>")
				print(str)
			}
		} catch {
			print("Error encoding :\(error)")
		}
	}
	
	
	func addSong(to albumcheck: Album, with song: Song) {
		for (index, album) in albums.enumerated() {
			if albumcheck.name == album.name {
				albums[index].songs.append(song)
			}
		}
	}

	init() {
		testDecodingExampleAlbum()
		albums[0].songs.append(Song(id: "", name: "", duration: ""))
	}
	
	var albums: [Album] = []
}
