//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController = AlbumController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        albumController.fetchAlbums(completion: { ( error) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumsCell", for: indexPath) 

        cell.textLabel?.text = albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist

        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSong" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            destinationVC?.albumController = albumController
        } else if segue.identifier == "showSong" {
            let destinationVC = segue.destination as? AlbumDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let album = albumController.albums[indexPath.row]
            
            destinationVC?.albumController = albumController
            destinationVC?.album = album
        }
    }


}
