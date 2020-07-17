//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)


        return cell
    }
    
}
