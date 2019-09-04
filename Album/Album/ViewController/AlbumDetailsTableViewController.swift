//
//  AlbumDetailsTableViewController.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class AlbumDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album?
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func saveTapped(_ sender: Any) {
    }
    

}
