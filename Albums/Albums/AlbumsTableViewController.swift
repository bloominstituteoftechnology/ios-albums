//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbums { success in
            if success {
                self.tableView.reloadData()
            } else {
                print("Unable to get albums from server")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private let albumController = AlbumController()

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }

//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumDetailVC = segue.destination as? AlbumDetailTableViewController {
            albumDetailVC.albumController = albumController
            
            if segue.identifier == "ShowAlbumSegue",
                let indexPath = tableView.indexPathForSelectedRow {
                albumDetailVC.album = albumController.albums[indexPath.row]
            }
        }
    }

}
