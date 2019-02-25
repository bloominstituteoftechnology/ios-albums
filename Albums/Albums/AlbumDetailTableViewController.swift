//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var urlsTextField: UITextField!
}
