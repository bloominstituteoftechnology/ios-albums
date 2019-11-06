//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums { error in
            if let error = error {
                fatalError("Couldn't load albums: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        cell.textLabel?.text = albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist

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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowAlbum" {
            guard let vc = segue.destination as? AlbumDetailTableViewController, let indexPathRow = tableView.indexPathForSelectedRow?.row else { return }
            vc.albumController = albumController
            vc.album = albumController.albums[indexPathRow]
        } else if segue.identifier == "SegueAddAlbum" {
            guard let vc = segue.destination as? AlbumDetailTableViewController else { return }
            vc.albumController = albumController
        }
    }
    

}
