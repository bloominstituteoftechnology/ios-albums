//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
    }
    
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    var albumController: AlbumController?
    var album: Album?
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtTextField: UITextField!
    
}
