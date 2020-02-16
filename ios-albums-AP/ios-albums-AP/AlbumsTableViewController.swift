//
//  AlbumsTableViewController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

// AddSegue
// DetailSegue

class AlbumsTableViewController: UITableViewController {

    // MARK: - Properties
    
    // Add this back?
    // var albumController: AlbumController?
    var albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumController = AlbumController()
        //albumController.testDecodingExampleAlbum()
        // This way the tableview always starts with the JSON album for testing
        albumController.testEncodingExampleAlbum()
        
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print("error gettingAlbums in ATVC: \(error)")
            }
            DispatchQueue.main.async {
                print("SUCCESS in getting albums")
                self.tableView.reloadData()
            }
        })
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let album = albumController.albums[indexPath.row]
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
        
        // pass albumController
        if segue.identifier == "AddSegue" {
            print("ADD")
            guard let detailVC = segue.destination as? AlbumDetailTableViewController else {return}
            detailVC.albumController = self.albumController
        }
        
        // pass albumController AND the album that corresponds to the cell
        if segue.identifier == "DetailSegue" {
            print("DETAIL")
            guard let detailVC = segue.destination as? AlbumDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let album = self.albumController.albums[indexPath.row]
            detailVC.albumController = self.albumController
            detailVC.album = album
        }
    }
}

