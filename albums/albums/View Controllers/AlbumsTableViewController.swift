//
//  AlbumsTableViewController.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumsTableViewCell else { fatalError("Failed to dequeue reusaable cell as \"albumCell\"")}

        let album = albumController.albums[indexPath.row]
        cell.albumTitleLabel.text = album.name
        cell.albumSubtitleLabel.text = album.artist
        // Configure the cell...

        return cell
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destVC = segue.destination as? AlbumsDetailTableViewController else { fatalError("Bad segue") }
        
        if segue.identifier == "viewExistingAlbumSegue" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Could not get indexPath.")}
            
            let album = albumController.albums[indexPath.row]
            destVC.album = album
            destVC.title = album.name
            destVC.albumController = AlbumController()
            
        } else {
            destVC.title = "Create New Album"
            destVC.albumController = AlbumController()
        }
        
    }

    // MARK: - Properties
    var albumController = AlbumController()
}
