//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Enrique Gongora on 3/9/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController: AlbumController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController?.getAlbums(completion: { (error) in
            if let error = error {
                NSLog("Error getting albums: \(error)")
                return
            }
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        cell.textLabel?.text = albumController?.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController?.albums[indexPath.row].artist
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            destinationVC?.albumController = albumController
        } else if segue.identifier == "DetailSegue" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let album = albumController?.albums[indexPath.row]
            destinationVC?.albumController = albumController
            destinationVC?.album = album
        }
    }
}
