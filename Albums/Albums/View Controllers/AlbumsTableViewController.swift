//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    let albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()

        albumController.getAlbums(completion: { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController.albums[indexPath.row]
        cell.textLabel?.text = album.albumName
        cell.detailTextLabel?.text = album.artist

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailTVC = segue.destination as! AlbumDetailTableViewController
        detailTVC.albumController = albumController
        
        if segue.identifier == "ToDetailView" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            let album = albumController.albums[index.row]
            detailTVC.album = album
        }
    }

}
