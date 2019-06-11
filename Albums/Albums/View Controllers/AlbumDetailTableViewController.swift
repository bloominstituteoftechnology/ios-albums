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
		
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 {
			return 1
		}
		return album?.songs.count ?? 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "albumDetailCell", for: indexPath)
		guard let albumDetailCell = cell as? AlbumDetailTableViewCell else { return cell }
		if indexPath.section == 0 {
			albumDetailCell.addSongButtonOutlet.isHidden = true
		}
		let song = album?.songs[indexPath.row]
		albumDetailCell.song = song
		
		return albumDetailCell
	}
	
	func setupViews() {
		guard let album = album else { return }
		print(album.name)
		albumTextField?.text = album.name
		artistTextField?.text = album.artist
		genresTextField?.text = album.genres[0]
		coverArtTextField?.text = "\(album.coverArt[0])"
		
	}
	
	var album: Album? 
	
	@IBOutlet var albumTextField: UITextField!
	@IBOutlet var artistTextField: UITextField!
	@IBOutlet var genresTextField: UITextField!
	@IBOutlet var coverArtTextField: UITextField!
}
