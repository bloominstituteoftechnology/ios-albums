//
//  AlbumsTableViewController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

// AddSegue
// DetailSegue

class AlbumsTableViewController: UITableViewController {

    // MARK: - Properties
    
    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print("error gettingAlbums in ATVC: \(error)")
            }
            DispatchQueue.main.async {
                print("SUCCESS in getting albums")
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let album = albumController.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        
        return cell
    }
    
    // MARK: - Navigation
    
    /// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // pass albumController
        if segue.identifier == "AddSegue" {
            print("ADD")
            guard let detailVC = segue.destination as? AlbumDetailTableViewController else {return}
            detailVC.albumController = self.albumController
        }
        
        // pass albumController AND the album that corresponds to the cell
        if segue.identifier == "DetailSegue" {
            print("DETAIL")
            guard let detailVC = segue.destination as? AlbumDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let album = self.albumController.albums[indexPath.row]
            detailVC.albumController = self.albumController
            detailVC.album = album
        }
    }
}

