//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
		setupViews()
		setupNavRightBUtton()
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
//	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//		return "check \(section)"
//	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 {
			return 1
		}
		return album?.songs.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "albumDetailCell", for: indexPath)
		guard let albumDetailCell = cell as? AlbumDetailTableViewCell else { return cell }

		if let song = album?.songs[indexPath.row], indexPath.section == 0 {
			albumDetailCell.song = song
			
		} else {
			albumDetailCell.song = nil
		}
		
		albumDetailCell.delegate = self
		return albumDetailCell
	}
	
	func setupViews() {
		guard let album = album else { return }
		title = album.name
		albumTextField?.text = album.name
		artistTextField?.text = album.artist
		genresTextField?.text = album.genres[0]
		coverArtTextField?.text = "\(album.coverArt[0])"
		
	}
	
	func setupNavRightBUtton() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
	}
	
	@objc func save() {
		//save to firebase
		guard let album = albumTextField.text,
			let artist = artistTextField.text,
			let genres = genresTextField.text,
			let coverArt = coverArtTextField.text else { return }
		
//		let url = URL(string: coverArt)
		let a = Album(artist: artist, name: album, genres: [genres], coverArt: [])
		
		albumController?.putAlbum(album: a, completion: { error in
			if let error = error {
				print("Error Puting to firebse : \(error)")
			}
			
				
				print(a)
				self.dismiss(animated: true)
			
		})
		
		
	}
	
	var album: Album?
	var albumController: AlbumController?
	
	@IBOutlet var albumTextField: UITextField!
	@IBOutlet var artistTextField: UITextField!
	@IBOutlet var genresTextField: UITextField!
	@IBOutlet var coverArtTextField: UITextField!
}

extension AlbumDetailTableViewController: AlbumDetailTableViewCellDelegate {
	func updateSongs(song: Song) {
		print(song)
		
		
		tableView.reloadData()
	}
	
	
}
