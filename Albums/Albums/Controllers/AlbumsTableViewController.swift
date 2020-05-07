//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Brian Rouse on 5/7/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UIViewController {

    // MARK: - IBOutlets & Properties

        @IBOutlet weak var tableView: UITableView!
        
        let albumController = AlbumController()
        
        
        
        // MARK: - View LifeCycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            loadAlbums()
            tableView.reloadData()
        }
       
        
        // MARK: - IBActions & Methods
        
        func loadAlbums() {
            albumController.loadAlbums { _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        

        
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowAlbumSegue" {
                guard let albumDetailVC = segue.destination as? AlbumDetailTableViewController,
                      let indexPath = tableView.indexPathForSelectedRow else { return }
                let album = albumController.albums[indexPath.row]
                albumDetailVC.album = album
            }
        }
        

    }

    extension AlbumsTableViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return albumController.albums.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
            let album = albumController.albums[indexPath.row]
            cell.textLabel?.text = album.name
            cell.detailTextLabel?.text = album.artist
            return cell
        }
        
        
    }
