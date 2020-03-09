//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Craig Swanson on 1/15/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var albumController: AlbumController? = AlbumController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let albumController = albumController else { return }
        albumController.getAlbums(completion: { (error) in
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let albumController = albumController else { return 0 }
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        guard let albumController = albumController else { return UITableViewCell() }

        cell.textLabel?.text = albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewAlbumSegue" {
            guard let newAlbumVC = segue.destination as? AlbumDetailTableViewController else { return }
            newAlbumVC.albumController = albumController
            newAlbumVC.delegate = self
            
        } else {
            guard let albumDetailVC = segue.destination as? AlbumDetailTableViewController else { return }
            albumDetailVC.albumController = albumController
            albumDetailVC.delegate = self
            if let indexPath = tableView.indexPathForSelectedRow {
                albumDetailVC.album = albumController?.albums[indexPath.row]
            }
            
        }
    }

}

// MARK: - AlbumDetailVCDelegate Conformance
extension AlbumsTableViewController: AlbumDetailVCDelegate {
    func albumWasCreated(_ album: Album) {
        albumController?.createAlbum(for: album)
        tableView.reloadData()
    }
    func albumWasUpdated(_ album: Album) {
        albumController?.update(for: album)
        tableView.reloadData()
    }
    
}
