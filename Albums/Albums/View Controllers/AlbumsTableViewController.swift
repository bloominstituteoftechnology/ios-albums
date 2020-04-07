//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums { Error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController.albums[indexPath.row]
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
    */
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard let showDetailVC = segue.destination as? AlbumDetailTableViewController else { return }
            showDetailVC.albumController = albumController
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            showDetailVC.album = albumController.albums[index]
        } else if segue.identifier == "AddAlbumSegue" {
            guard let addAlbumVC = segue.destination as? AlbumDetailTableViewController else { return }
            addAlbumVC.albumController = albumController
        }
    }

}
