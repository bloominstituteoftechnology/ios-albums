//
//  AlbumDetailTableViewController.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
	@IBOutlet var albumNameTextField: UITextField!
	@IBOutlet var artistNameTextField: UITextField!
	@IBOutlet var genresTextField: UITextField!
	@IBOutlet var coverArtTextField: UITextField!

	var anAlbumController: AnAlbumController?
	var album: AnAlbum? {
		didSet {
			updateViews()
		}
	}

	private func updateViews() {
		guard let album = album else { return }
		albumNameTextField.text = album.name
		artistNameTextField.text = album.artist
		genresTextField.text = album.genres.joined(separator: ", ")
		coverArtTextField.text = album.coverArt.map { $0.absoluteString }.joined(separator: ", ")

		tableView.reloadData()
	}
}

extension AlbumDetailTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return album?.songs.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)

		return cell
	}
}
