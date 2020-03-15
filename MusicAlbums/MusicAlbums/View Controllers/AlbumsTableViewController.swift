//
//  AlbumsTableViewController.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/11/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
//    var albumController: AlbumController?
    let albumController = AlbumController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        albumController.getAlbumsFromServer { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
               
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.getAlbumsFromServer { error in
            if let error = error {
                print("error fetching data: \(error)")
            }
             DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
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
        cell.largeContentTitle = "My TITLE"
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        print(cell)
        return cell
//        cell.textLabel?.text = albumController.albums[indexPath.row].name
//        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist
//        return cell
    }
    
    // Pull to Refresh View

    @IBAction func pullToRefresh(_ sender: Any) {
        albumController.getAlbumsFromServer(completion: { (_) in
            self.refreshControl?.endRefreshing()
        })
    }
    
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            case "ShowDetailViewSegue":
                guard let detailVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
                detailVC.albumcontroller = albumController
                detailVC.album = albumController.albums[indexPath.row]
            case "AddAlbumSegue":
                guard let detailVC = segue.destination as? AlbumDetailTableViewController else { return }
                detailVC.albumcontroller = albumController
            default:
                break
        }
        
    }
}
