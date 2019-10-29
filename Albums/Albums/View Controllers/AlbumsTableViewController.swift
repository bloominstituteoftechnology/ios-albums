//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController?.getAlbums()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return albumController?.albums.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albums", for: indexPath)
        
        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.name
        cell.detailTextLabel!.text = album?.artist
        
        return cell
    }
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAlbumSegue" {
            if let addAlbumVC = segue.destination as? AlbumDetailTableViewController {
                addAlbumVC.albumController = albumController
            }
        } else if segue.identifier == "showAlbumDetail" {
            if let showAlbumVC = segue.destination as? AlbumDetailTableViewController {
                showAlbumVC.albumController = albumController
            }
        }
    }
}
