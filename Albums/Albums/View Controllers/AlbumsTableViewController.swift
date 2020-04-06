//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbums() { error in
            if let error = error {
                NSLog("error getting albums \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbumDetailSegue" {
            guard let selected = tableView.indexPathForSelectedRow else { return }
            guard let AlbumDetailVC = segue.destination as? AlbumDetailTableViewController else { return }
            AlbumDetailVC.album = albumController.albums[selected.row]
            AlbumDetailVC.albumController = albumController
        } else if segue.identifier == "ShowNewAlbumSegue" {
            guard let NewAlbumVC = segue.destination as? AlbumDetailTableViewController else { return }
            NewAlbumVC.albumController = albumController
        }
    }
    

}
