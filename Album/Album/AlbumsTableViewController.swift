//
//  AlbumsTableViewController.swift
//  Album
//
//  Created by Lydia Zhang on 4/6/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    var albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.fetchAlbum() { error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddSegue":
            if let addVC = segue.destination as? AlbumsDetailTableViewController {
                addVC.albumController = albumController
            }
        case "DetailSegue" :
            if let detailVC = segue.destination as? AlbumsDetailTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.album = albumController.albums[indexPath.row]
                    detailVC.albumController = albumController
                }
            }
        default:
            break
        }
    }
    

}
