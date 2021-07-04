//
//  AlbumsVC.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class AlbumsVC: UITableViewController {

	//MARK: - IBOutlets
	
	
	//MARK: - Properties
	
	let albumController = AlbumController()
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		fetchAlbums()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let detailsVC = segue.destination as? AlbumDetailsVC {
			if let indexPath = tableView.indexPathForSelectedRow {
				detailsVC.album = albumController.findAlbum(by: indexPath)
			}
			detailsVC.albumController = albumController
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func fetchAlbums() {
		albumController.getAlbums { (result) in
			if let _ = try? result.get() {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return albumController.albumsByArtist.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let sectionKey = Array(albumController.albumsByArtist.keys)[section]
        return albumController.albumsByArtist[sectionKey]?.count ?? 0
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return Array(albumController.albumsByArtist.keys)[section]
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
		let album = albumController.findAlbum(by: indexPath)
		
		cell.textLabel?.text = album?.title
		cell.detailTextLabel?.text = album?.artist

        return cell
    }
}
