//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var albumsNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    @IBOutlet weak var urlsTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    

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

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell

        // Configure the cell...

        return cell
    }


   
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}
