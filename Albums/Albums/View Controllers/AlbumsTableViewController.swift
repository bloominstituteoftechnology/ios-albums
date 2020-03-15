//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    // MARK: - Properties

    var albumController = AlbumController()
    
    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbums()
    }

    // MARK: - Private Methods
    
    private func fetchAlbums() {
        albumController.getAlbums(completion: { (error) in
            if error == nil {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count// ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? AlbumDetailTableViewController {
            
            switch segue.identifier {
                
            case "ShowAddAlbumSegue":
                detailVC.albumController = albumController
                detailVC.delegate = self
                
            case "ShowAlbumDetailSegue":
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                detailVC.albumController = albumController
                detailVC.album = albumController.albums[indexPath.row]
                detailVC.delegate = self
                
            default:
                return
            }
        }
    }
}

extension AlbumsTableViewController: AlbumDetailTableViewControllerDelegate {
    func updatedAlbumDataSource() {
        tableView.reloadData()
    }
}
