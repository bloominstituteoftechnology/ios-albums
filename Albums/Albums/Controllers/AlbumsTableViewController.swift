//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    let albumController: AlbumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        albumController.getAlbums(completion: { error in
            if let error = error {
                NSLog("Error : \(error)")
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

        // Configure the cell...
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddAlbumSegue" {
            guard let detailVC = segue.destination as? AlbumDetailTableViewController else { fatalError()}
            detailVC.albumController = albumController
        }
        
        if segue.identifier == "ViewAlbumSegue" {
            guard let detailVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { fatalError()}
            detailVC.albumController = albumController
            detailVC.album = albumController.albums[indexPath.row]
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
