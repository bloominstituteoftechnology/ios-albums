//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Morgan Smith on 5/14/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        albumController.getAlbums { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

  

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


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
                   
                   guard let destinationVC = segue.destination as? AlbumDetailTableViewController else { return }
                   
                   destinationVC.albumController = albumController
                   
               } else if segue.identifier == "DetailSegue" {
                   guard let destinationVC = segue.destination as? AlbumDetailTableViewController,
                       let indexPath = tableView.indexPathForSelectedRow else { return }
                   
                   let album = albumController.albums[indexPath.row]
                   
                   destinationVC.album = album
                   destinationVC.albumController = albumController
               }
           }

}
