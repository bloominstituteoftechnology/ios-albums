//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController = AlbumController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print("\(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        // Configure the cell...
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detailVC = segue.destination as? AlbumDetailTableViewController {
            detailVC.albumController = self.albumController
            if let indexPath = tableView.indexPathForSelectedRow,
                segue.identifier == "ShowDetailAlbumSegue" {
                detailVC.album = self.albumController.albums[indexPath.row]
            }
        }
    }
}
