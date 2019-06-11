//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albumController.albums.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
		let album = albumController.albums[indexPath.row]
		cell.textLabel?.text = album.name
		cell.detailTextLabel?.text = album.artist
		
		return cell
	}
	
	
	let albumController = AlbumController()
}
