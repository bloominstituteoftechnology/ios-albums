//
//  AlbumDetailTableViewController.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        return
    }
    
    
    var albumController: AlbumController?
    var album: Album?
    var tempSongs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Songs"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let album = album else { return 0}
        return album.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
        cell.song = album?.songs[indexPath.row]
        cell.delegate = self
        // Configure the cell...
        cell.updateViews()
        return cell
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Mark: - Functions
    
    func updateViews() {
        guard let album = album else { return }
        
        navigationItem.title = album.name
        albumTextField.text = album.name
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        let urlStrings = album.coverArt.compactMap({ $0.absoluteString })
        imageTextField.text = urlStrings.joined(separator: ", ")
    }
    
    // Mark: - Outlets
    
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}
