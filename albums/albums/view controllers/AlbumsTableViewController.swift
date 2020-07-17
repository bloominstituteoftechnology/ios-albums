//
//  AlbumsTableViewController.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albumController: AlbumController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  need to perform error handling, et cetera
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
        guard let album = albumController?.albums[indexPath.row] else { return cell }
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumDetailVC = segue.destination as? AlbumDetailTableViewController {
            albumDetailVC.albumController = albumController
            if let index = tableView.indexPathForSelectedRow?.row, segue.identifier == "EditAlbumSegue" {
                albumDetailVC.album = albumController?.albums[index]
            }
        }
    }

}
