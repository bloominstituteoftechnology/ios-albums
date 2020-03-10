//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums { (error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        if segue.identifier == "AddDetailTableSegue" {
            if let detailVC = segue.destination as? AlbumDetailTableViewController {
                detailVC.albumController = albumController
            }
            
        } else if segue.identifier == "ShowDetailTableSegue" {
            if let detailVC = segue.destination as? AlbumDetailTableViewController {
                detailVC.albumController = albumController
                if let index = tableView.indexPathForSelectedRow {
                    let album = albumController.albums[index.row]
                    detailVC.album = album
                }
            }
        }
    }
    
}
