//
//  AlbumsDetailTableViewController.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class AlbumsDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? AlbumsDetailTableViewCell else {fatalError("Unable to dequeue cell as AlbumsDetailTableViewCell")}

        // Configure the cell...

        return cell
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    @IBAction func addSong(_ sender: Any) {
        
    }
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genreNameTextField: UITextField!
    @IBOutlet weak var coverImageURLsTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
}
