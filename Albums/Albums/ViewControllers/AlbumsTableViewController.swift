//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Chris Gonzales on 3/9/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let albumController = albumController else { return }
        albumController.getAlbums { (error) in
            if let error = error{
                NSLog("Error getting albums: \(error)")
                return
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.songCellID, for: indexPath) as? SongTableViewCell,
        let albumController = albumController else { return UITableViewCell() }
        cell.albumController = albumController
        cell.album = albumController.albums[indexPath.row]
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let albumController = albumController else { return }
        if segue.identifier == Keys.addAlbumSegue {
            if let addVC = segue.destination as? AlbumDetailTableViewController {
                addVC.albumController = albumController
            }
        } else if segue.identifier == Keys.albumDetailSegue {
            if let detailVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.albumController = albumController
                detailVC.album = albumController.albums[indexPath.row]
            }
        }
    }
}
