//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    let albumController = AlbumController()

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.createAlbum(name: "Name", artist: "Artist", id: UUID().uuidString, genres: ["Genre"], coverArt: ["www.google.com"], songs: [Song(title: "Title", duration: "5:25", id: UUID().uuidString)])
        print(albumController.albums)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}
