//
//  AlbumsTableViewController.swift
//  Albums Sprint Challenge
//
//  Created by Elizabeth Wingate on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController = AlbumController()
        

        override func viewDidLoad() {
            super.viewDidLoad()

            albumController.getAlbums(completion: { ( error) in
                if let error = error {
                    print("\(error)")
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
            // #warning Incomplete implementation, return the number of rows
            return albumController.albums.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

            cell.textLabel?.text = albumController.albums[indexPath.row].name
            cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist

            return cell
        }
    
        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AddSegue" {
                let destinationVC = segue.destination as? AlbumDetailTableViewController
                destinationVC?.albumController = albumController
            } else if segue.identifier == "CellSegue" {
                let destinationVC = segue.destination as? AlbumDetailTableViewController
                guard let indexPath = tableView.indexPathForSelectedRow else {return}
                let album = albumController.albums[indexPath.row]
                
                destinationVC?.albumController = albumController
                destinationVC?.album = album
            }
        }
    }
