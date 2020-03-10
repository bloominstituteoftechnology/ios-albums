//
//  AlbumsTableViewController.swift
//  Album
//
//  Created by Christy Hicks on 1/16/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    // MARK: - Properties
    let albumController = AlbumController()
    
    // MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        albumController.getAlbums { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            albumController.albums.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            
            guard let destinationVC = segue.destination as? AlbumDetailViewController else { return }
            
            destinationVC.albumController = albumController
            albumController.songList.removeAll()
            
        } else if segue.identifier == "detailSegue" {
            guard let destinationVC = segue.destination as? AlbumDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let album = albumController.albums[indexPath.row]
            
            destinationVC.album = album
            destinationVC.albumController = albumController
        }
    }
}
