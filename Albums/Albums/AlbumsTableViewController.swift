//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController?.getAlbums(completion: { (error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.name
        cell.detailTextLabel?.text = album?.artist
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddAlbum" {
            guard let albumDetailVC = segue.destination as? AlbumDetailTableViewController else { return }
            albumDetailVC.albumController = albumController
        } else {
            guard let albumDetailVC = segue.destination as? AlbumDetailTableViewController,
            let index = tableView.indexPathForSelectedRow else { return }
            albumDetailVC.albumController = albumController
            albumDetailVC.album = albumController?.albums[index.row]
        }
    }

    var albumController: AlbumController?
}
