//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Chad Rutherford on 1/13/20.
//  Copyright © 2020 chadarutherford.com. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var albumController: AlbumController?
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController?.getAlbums { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            
            self.tableView.reloadData()
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.showAddAlbumSegue:
            guard let albumDetailVC = segue.destination as? AlbumDetailTableViewController else { return }
            albumDetailVC.albumController = albumController
        case Segues.showAlbumDetailSegue:
            guard let albumDetailVC = segue.destination as? AlbumDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            albumDetailVC.albumController = albumController
            albumDetailVC.album = albumController?.albums[indexPath.row]
        default:
            break
        }
    }

    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.albumCell, for: indexPath)
        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.name
        cell.detailTextLabel?.text = album?.artist
        return cell
    }
}
