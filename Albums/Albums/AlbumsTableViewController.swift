//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Kobe McKee on 6/10/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                NSLog("Error getting ablums: \(error)")
            }
            
        })
        self.tableView.reloadData()
    }


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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddAlbumSegue" {
            guard let destinationVC = segue.destination as? AlbumDetailTableViewController else { return }
            destinationVC.albumController = albumController
        }
        
        if segue.identifier == "AlbumDetailSegue" {
            guard let destinationVC = segue.destination as? AlbumDetailTableViewController else { return }
           
            destinationVC.albumController = albumController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.album = albumController.albums[indexPath.row]
            }
        }
    }
    

}
