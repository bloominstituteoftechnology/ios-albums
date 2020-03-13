//
//  AlbumsTableViewController.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumController.getAlbums(completion: { (error) in
            if let error = error {
                print("error fetching data: \(error)")
                return
            }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        })
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath)

        cell.textLabel?.text = albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAlbumSegue" {
            guard let destinationVC = segue.destination as? AlbumDetailTableViewController else { return }
            destinationVC.albumController = albumController
        } else if segue.identifier == "detailViewSegue" {
            guard let detinationVC = segue.destination as? AlbumDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            detinationVC.album = albumController.albums[indexPath.row]
            detinationVC.albumController = albumController
        }
    }
}
