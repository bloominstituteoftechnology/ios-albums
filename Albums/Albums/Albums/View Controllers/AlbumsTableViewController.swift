//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by David Williams on 5/14/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.name
        cell.detailTextLabel?.text = album?.artist

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
//AddAlbumSegue
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbumSegue",
            let showVC = segue.destination as? AlbumDetailTableViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            showVC.albumController = albumController
            showVC.album = albumController?.albums[selectedIndexPath.row]
        } else if segue.identifier == "AddAlbumSegue" {
            guard let addVC = segue.destination as? AlbumDetailTableViewController else { return }
            addVC.albumController = albumController
        }
    }
}
