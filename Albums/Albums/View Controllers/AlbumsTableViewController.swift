//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by morse on 12/2/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let albumController = AlbumController()
    
    struct PropertyKeys {
        static let cell = "AlbumCell"
        
        static let addSegue = "ShowAddAlbumSegue"
        static let detailSegue = "ShowAlbumDetailSegue"
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        albumController.getAlbums { error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cell, for: indexPath)

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.detailSegue {
            guard let detailVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.albumController = albumController
            detailVC.album = albumController.albums[indexPath.row]
        } else if segue.identifier == PropertyKeys.addSegue {
            guard let addVC = segue.destination as? AlbumDetailTableViewController else { return }
            addVC.albumController = albumController
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
