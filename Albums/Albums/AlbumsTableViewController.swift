//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Gladymir Philippe on 7/16/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
   
    var albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.albumController.getAlbums() { (error) in
            print("Number of albums: \(self.albumController.albums)")
            DispatchQueue.main.async {
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
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.albumController.albums.count)
        print(albumController.albums.count)
        return self.albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let album = self.albumController.albums[indexPath.row]
        cell.textLabel!.text = album.name
        cell.detailTextLabel!.text = album.artist
        print("This is the cell: \(cell)")
        

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showCellAlbumDetail" {
                let destinationVC = segue.destination as! AlbumDetailTableViewController
                destinationVC.albumController = self.albumController
                let cell = sender as! UITableViewCell
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                destinationVC.album = self.albumController.albums[indexPath.row]
            }
            
            if segue.identifier == "showAlbum" {
                let destinationVC = segue.destination as! AlbumDetailTableViewController
                destinationVC.albumController = self.albumController
            }
        }
    }
    


