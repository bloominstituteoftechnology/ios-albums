//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let albumController = albumController else { return }
        albumController.getAlbums()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumController = albumController else { return 0 }
        let rows = albumController.albums.count
        return rows
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        if let albumController = albumController {
            let album = albumController.albums[indexPath.row]
            cell.albumName.text = album.name
            cell.artistName.text = album.artist
        }
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbumDetailFromAdd" {
            if let destinationVC = segue.destination as? AlbumDetailTableViewController {
               destinationVC.albumController = albumController
            }
        }
        
        if segue.identifier == "ShowAlbumDetailFromCell" {
            if let destinationVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                guard let albumController = albumController else { return }
                destinationVC.albumController = albumController
                destinationVC.album = albumController.albums[indexPath.row]
            }
        }
    }
}
