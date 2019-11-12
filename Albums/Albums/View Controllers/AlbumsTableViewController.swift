//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Bobby Keffury on 10/30/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController = AlbumController()
    var albums: [Album] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbums(completion: { (albumsResult, error) in
            if let error = error {
                print("Error getting Albums: \(error)")
                return
            }
            
            if let albums = albumsResult {
                DispatchQueue.main.async {
                    self.albums = albums
                    self.tableView.reloadData()
                }
            }
        })
        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        let album = albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

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
        if segue.identifier == "AlbumDetailShowSegue" {
            if let detailVC = segue.destination as? AlbumDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow {
                detailVC.albumController = albumController
                detailVC.album = albums[indexPath.row]
            }
        } else if segue.identifier == "AddAlbumSegue" {
            if let detailVC = segue.destination as? AlbumDetailTableViewController {
                detailVC.albumController = albumController
            }
        }
    }
    

}
