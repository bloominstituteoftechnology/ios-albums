//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = albumController?.createSong(withTitle: title, andDuration: duration)
        tempSongs.append(song!)
        tableView.reloadData()
       // tableView.scrollToRow(at: <#T##IndexPath#>, at: <#T##UITableView.ScrollPosition#>, animated: <#T##Bool#>)
        
    }
    

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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    /*In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var tempSongs: [Song] = []
    
    var albumController: AlbumController?
    
    var album: Album?  {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let album = album {
        
        albumNameTextField.text = album.name
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ",")
      //  urlTextField.text = album.coverArt I don't know how to separate this
        
        title = album.name
      //  tempSongs = album
    }
}
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var albumNameTextField: UITextField!
    
    @IBOutlet weak var artistTextField: UITextField!
    
    @IBOutlet weak var genreTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    
    
    

}
