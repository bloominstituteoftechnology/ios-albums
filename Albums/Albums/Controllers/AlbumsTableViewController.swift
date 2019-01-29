//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Sergey Osipyan on 1/28/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController: AlbumController? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        albumController?.getAlbums()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController?.albums.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        cell.textLabel?.text = albumController?.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController?.albums[indexPath.row].artist

        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let destination = segue.destination as? AlbumDetailTableViewController
            destination?.albumController = albumController
         
        } else {
            let cellDestination = segue.destination as? AlbumDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            cellDestination?.album = albumController?.albums[(indexPath?.row)!]
            cellDestination?.albumController = albumController
        }
        
    }
  

}
