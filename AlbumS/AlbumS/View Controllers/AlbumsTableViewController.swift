//
//  AlbumsTableViewController.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let albumController = AlbumController()
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums(completion: { (_) in
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

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    //MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Helper.albumCell, for: indexPath)
        
        let album = albumController.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        return cell
    }
    
    
    
    //MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Helper.addButtonSegue {
            let destVC = segue.destination as! AlbumDetailViewController
            destVC.albumController = albumController
        } else if segue.identifier == Helper.cellSegue {
            let destVC = segue.destination as! AlbumDetailViewController
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            destVC.album = albumController.albums[selectedIndex.row]
            destVC.albumController = albumController
        }
    }
    
    
    
    
    
}
