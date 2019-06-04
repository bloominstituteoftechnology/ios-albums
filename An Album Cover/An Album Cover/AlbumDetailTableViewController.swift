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
	@IBOutlet var saveButton: UIBarButtonItem!

	var anAlbumController: AnAlbumController?
	var album: AnAlbum? {
		didSet {
			updateViews()
		}
	}
	var tempSongs = [Song]()

	override func viewDidLoad() {
		super.viewDidLoad()
		updateViews()
	}

	private func updateViews() {
		navigationItem.title = "New Album"
		guard let album = album, isViewLoaded else { return }
		albumNameTextField.text = album.name
		artistNameTextField.text = album.artist
		genresTextField.text = album.genres.joined(separator: ", ")
		coverArtTextField.text = album.coverArt.map { $0.absoluteString }.joined(separator: ", ")
		navigationItem.title = album.name
		tempSongs = album.songs

		tableView.reloadData()
	}

	@IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
		guard let albumName = albumNameTextField.text, !albumName.isEmpty,
			let artistName = artistNameTextField.text, !artistName.isEmpty,
			let genres = genresTextField.text, !genres.isEmpty,
			let coverArt = coverArtTextField.text else { return }
		if let album = album {
			//update
			anAlbumController?.updateAlbum(album: album, artist: artistName, coverArtString: coverArt, genres: genres, name: albumName, songs: tempSongs)
		} else {
			// create
			anAlbumController?.createAlbum(artist: artistName, coverArtString: coverArt, genres: genres, name: albumName, songs: tempSongs)
		}

		navigationController?.popViewController(animated: true)
	}
}

extension AlbumDetailTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tempSongs.count + 1
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return indexPath.row == tempSongs.count ? 140 : 100
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
		guard let songCell = cell as? SongTableViewCell else { return cell }

		songCell.delegate = self
		if indexPath.row < tempSongs.count {
			songCell.song = tempSongs[indexPath.row]
		}

		return songCell
	}
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
	func addSong(with title: String, duration: String) {
		guard let newSong = anAlbumController?.createSong(named: title, duration: duration) else { return }
		tempSongs.append(newSong)
		tableView.reloadData()
	}
}
