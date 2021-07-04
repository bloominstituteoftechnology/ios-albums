//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                NSLog("\(error)")
            }
            self.tableView.reloadData()
        })

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        if segue.identifier == "AddAlbum" {
            let destinationVC = segue.destination as! AlbumDetailTableViewController
            destinationVC.albumController = albumController
        }
        if segue.identifier == "ShowAlbum" {
            let destinationVC = segue.destination as! AlbumDetailTableViewController
            destinationVC.albumController = albumController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.album = albumController.albums[indexPath.row]
        }
    }

    var albumController = AlbumController()
}
