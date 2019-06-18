//
//  AlbumsTableViewController.swift
//  AlbumHWRepeat
//
//  Created by Michael Flowers on 6/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController: AlbumController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController?.getAlbums(completion: { (_) in
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController?.albums.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 

        // Configure the cell...
        cell.textLabel?.text = albumController?.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController?.albums[indexPath.row].artist
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CellSegue" {
            guard let destinationVC = segue.destination as? DetailTableViewController, let indexPath = tableView.indexPathForSelectedRow, let albumController = albumController else { print("error in the cell segue") ; return }
            
            let albumToPass = albumController.albums[indexPath.row]
            destinationVC.album = albumToPass
            destinationVC.albumController = albumController
        }
        
        if segue.identifier == "AddSegue" {
            guard let destinationVC = segue.destination as? DetailTableViewController, let albumController = albumController else { print("error in the Add segue") ; return }
    
            destinationVC.albumController = albumController
        }
    }
}
