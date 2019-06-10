//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
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


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    @IBOutlet weak var albumNameTextField: UITextField!

    @IBOutlet weak var artistTextField: UITextField!

    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var imagesTextField: UITextField!
}
