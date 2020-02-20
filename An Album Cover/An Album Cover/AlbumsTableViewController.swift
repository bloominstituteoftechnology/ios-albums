//
//  AlbumsTableViewController.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

	let anAlbumController = AnAlbumController()

	override func viewDidLoad() {
		super.viewDidLoad()
		anAlbumController.getAlbums { [weak self] (result: Result<[AnAlbum], NetworkError>) in
			DispatchQueue.main.async {
				do {
					_ = try result.get()
				} catch {
					NSLog("There was an error: \(error)")
				}
				self?.tableView.reloadData()
			}
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? AlbumDetailTableViewController {
			dest.anAlbumController = anAlbumController

			if segue.identifier == "ShowAlbumDetail" {
				guard let indexPath = tableView.indexPathForSelectedRow else { return }
				dest.album = anAlbumController.albums[indexPath.row]
			}
		}
	}
}

extension AlbumsTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return anAlbumController.albums.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let album = anAlbumController.albums[indexPath.row]
		cell.imageView?.image = nil
		cell.textLabel?.text = album.name
		cell.detailTextLabel?.text = album.artist
		if let artURL = album.coverArt.first {
			anAlbumController.get(albumArtAt: artURL) { (result: Result<Data, NetworkError>) in
				DispatchQueue.main.async {
					do {
						let data = try result.get()
						guard let image = UIImage(data: data) else {
							throw NetworkError.imageDecodeError
						}
						cell.imageView?.image = image
						cell.layoutSubviews()
					} catch {
						NSLog("error fetching art: \(error)")
					}
				}
			}
		}
		return cell
	}
}
