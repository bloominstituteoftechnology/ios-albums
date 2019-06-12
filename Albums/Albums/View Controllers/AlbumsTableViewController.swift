//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		albumController.getAlbums { result in
			if let result = try? result.get() {
				self.albums = result
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albums.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
		let album = albums[indexPath.row]
		cell.textLabel?.text = album.name
		cell.detailTextLabel?.text = album.artist
		
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "albumDetailSegue" {
			guard let vc = segue.destination as? AlbumDetailTableViewController,
				let indexpath = tableView.indexPathForSelectedRow else { return }
			
			let album = albums[indexpath.row]
			vc.album = album
			vc.albumController = albumController
		} else if segue.identifier == "AddAlbumSegue" {
			guard let vc = segue.destination as? AlbumDetailTableViewController else { return }
			vc.albumController = albumController
		}
	}
	
	let albumController = AlbumController()
	var albums: [Album] = []
}
