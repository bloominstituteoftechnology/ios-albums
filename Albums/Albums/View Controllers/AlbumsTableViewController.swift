//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Michael Stoffer on 7/22/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    let albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbums { (error) in
            if let error = error {
                NSLog("Error getting albums: \(error)")
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = self.albumController.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

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
        if segue.identifier == "AddAlbum" {
            guard let adtVC = segue.destination as? AlbumDetailTableViewController else { return }
            adtVC.albumController = self.albumController
        }
        
        if segue.identifier == "EditAlbum" {
            guard let adtVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let album = self.albumController.albums[indexPath.row]
            adtVC.albumController = self.albumController
            adtVC.album = album
        }
    }
}
