//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                NSLog("Error getting albums: \(error)")
                return
            }
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albumController.albums.count
    }
    
    let reuseIdentifier = "AlbumCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        cell.selectionStyle = .none
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            
//            // Delete the row from the data source
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCreateAlbum" {
            guard let destination = segue.destination as? AlbumDetailTableViewController else { return }
            
            destination.albumController = albumController
        } else if segue.identifier == "ShowAlbumDetail" {
            guard let destination = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let album = albumController.albums[indexPath.row]
            
            destination.albumController = albumController
            destination.album = album
        }
    }
    
    // MARK: - Properties
    
    let albumController = AlbumController()
    
}
