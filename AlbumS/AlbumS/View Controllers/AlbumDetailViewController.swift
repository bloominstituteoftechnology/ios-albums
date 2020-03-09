//
//  AlbumDetailViewController.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController {

    
    //MARK:- IBOutlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album?
    
    
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

   
}
