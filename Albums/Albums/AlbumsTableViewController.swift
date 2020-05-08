//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Marissa Gonzales on 5/7/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.fetchAlbums { (error) in
            if let error = error {  
                print("\(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return albumController.albums.count
    }

    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSongSegue" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            destinationVC?.albumController = albumController
        } else if segue.identifier == "ShowSongSegue" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let album = albumController.albums[indexPath.row]
            
            destinationVC?.albumController = albumController
            destinationVC?.album = album
        }

    }
}
