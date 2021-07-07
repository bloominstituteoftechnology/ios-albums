//
//  AlbumsTableViewController.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController = AlbumController()
    let tvcDebug: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("Error GETing Albums: \(error)")
                    let alert = UIAlertController(title: "Error", message: "Error GETing Albums: \(error)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                self.tableView.reloadData()
            }
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tvcDebug { print ("Album count: \(albumController.albums.count)")}
        return albumController.albums.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbulmCell", for: indexPath)
        if tvcDebug { print ("Album name: \(albumController.albums[indexPath.row].name)")}
        cell.textLabel?.text = albumController.albums[indexPath.row].name
        if tvcDebug { print ("Album artist: \(albumController.albums[indexPath.row].artist)")}
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
        guard let vc = segue.destination as? AlbumDetailTableViewController else { return }
        vc.albumController = albumController
        switch segue.identifier {
        case "AlbumDetailSegue":
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                vc.album = albumController.albums[indexPath]
            }
        default:
            vc.albumController = albumController
            return
        }
    }

}
