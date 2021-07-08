//
//  AlbumsTableViewController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(check))
	}
	
	@objc func check() {
		let a = albumController.albums[0]
		albumController.testEncodingExampleAlbum(album: a)
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albumController.albums.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
		let album = albumController.albums[indexPath.row]
		cell.textLabel?.text = album.name
		cell.detailTextLabel?.text = album.artist
		
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "cellSegue" {
			print("here")
			guard let vc = segue.destination as? AlbumViewController,
				let cell = sender as? UITableViewCell,
				let indexpath = tableView.indexPath(for: cell) else { return }
			
			
			let album = albumController.albums[indexpath.row]
			vc.album = album
			vc.albumController = albumController
		} else if segue.identifier == "" {
			
		}
	}
	

	
	
	let albumController = AlbumController()
}
