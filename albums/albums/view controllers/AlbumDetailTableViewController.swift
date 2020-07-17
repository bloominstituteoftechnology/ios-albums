//
//  AlbumDetailTableViewController.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    var albumController: AlbumController?
    var album: Album?
    
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtURL: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func save(_ sender: Any) {
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
