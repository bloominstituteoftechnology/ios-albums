//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print(error)
            }
            self.tableView.reloadData()
        })
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        if segue.identifier == "AlbumDetail" {
            guard let cellDetailController = segue.destination as? AlbumDetailTableViewController, let cell = sender as? SongTableViewCell else { return }
            
            cellDetailController.albumController = albumController
            cellDetailController.album = cell.album
            
        } else if segue.identifier == "NewAlbum" {
            guard let addAlbumController = segue.destination as? AlbumDetailTableViewController else { return }
            
            addAlbumController.albumController = albumController
            
        }
    }
    

}
