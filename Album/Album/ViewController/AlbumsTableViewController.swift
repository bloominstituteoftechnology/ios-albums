//
//  AlbumsTableViewController.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    let albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print("error getting album: \(error)")
                return
            }
            self.tableView.reloadData()
        })
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
        guard let albumDetailTableVC = segue.destination as? AlbumDetailsTableViewController else { return }
        if segue.identifier == "ShowAlbumSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            albumDetailTableVC.album = albumController.albums[indexPath.row]
            albumDetailTableVC.albumController = albumController
        }
        if segue.identifier == "AddAlbumSegue" {
            albumDetailTableVC.albumController = albumController
        }
    }
}
