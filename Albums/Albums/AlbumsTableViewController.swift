//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_218 on 1/13/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController?.getAlbums(completion: { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            self.tableView.reloadData()
        })
    
       
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController?.albums.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.albumCell , for: indexPath)
        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.name
        cell.detailTextLabel?.text = album?.artist
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.ShowAlbumDetialSegue:
            guard let albumDetailVC = segue.destination as? AlbumDetialTableViewController else { return }
            albumDetailVC.albumController = albumController
        case Segues.ShowDDAlbumSegue:
            guard let albumDetailVC = segue.destination as? AlbumDetialTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            albumDetailVC.albumController = albumController
            albumDetailVC.album = albumController?.albums[indexPath.row]
            
        default:
            break
            
            
        }
    }
    

   

}
