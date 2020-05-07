//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Nonye on 5/7/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    // MARK: - OUTLETS
    
    @IBOutlet weak var albumNameText: UITextField!
    @IBOutlet weak var artistNameText: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    // MARK: - ACTION
    
    @IBAction func saveButtonTapped(_ sender: Any) {
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
