//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Enrique Gongora on 3/9/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverURLTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Variables
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func updateViews() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
