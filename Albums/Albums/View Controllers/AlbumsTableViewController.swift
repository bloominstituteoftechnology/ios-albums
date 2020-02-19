//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        albumController.getAlbums { (error) in
            if let error = error {
                NSLog("Error getting albums: \(error)")
            }
            print(self.albumController.albums)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController.albums[indexPath.row]
        cell.textLabel?.text = album.albumTitle
        cell.detailTextLabel?.text = album.artist
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewAlbum" {
            guard let showAlbumVC = segue.destination as? AlbumDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            showAlbumVC.albumController = albumController
            showAlbumVC.album = albumController.albums[indexPath.row]
        } else {
            guard let createAlbumVC = segue.destination as? AlbumDetailTableViewController else { return }
            createAlbumVC.albumController = albumController
        }
    }


}
