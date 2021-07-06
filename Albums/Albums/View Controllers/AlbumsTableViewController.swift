//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let albumDetailVC = segue.destination as? AlbumDetailTableViewController {
            albumDetailVC.albumController = albumController
            
            if segue.identifier == "ShowAlbumDetailSegue", let indexPath = tableView.indexPathForSelectedRow {
                albumDetailVC.album = albumController.albums[indexPath.row]
            }
        }
        
        
    }

}
