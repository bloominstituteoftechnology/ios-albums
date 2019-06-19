//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        albumController?.getAlbums(completion: { (error) in
            if let error = error {
                NSLog("Error loading albums: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
      
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController?.albums.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.albumName
        cell.detailTextLabel?.text = album?.artist

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            let destinationVC = segue.destination as! AlbumDetailTableViewController
            destinationVC.albumController = albumController
        } else if segue.identifier == "CellSegue" {
            let detailVC = segue.destination as! AlbumDetailTableViewController
            //index path
            //set destination album and controller
        }
    }
 
    var albumController: AlbumController?
    
    

}
