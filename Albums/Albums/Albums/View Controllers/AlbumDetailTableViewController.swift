//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by David Williams on 5/14/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController { //}, SongTableViewCellDelegate {
   
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            guard isViewLoaded else { return}
            updateViews()
        }
    }
    // discouraged, demoralized, & dispassionate
    var tempSongs: [Song] = []

    @IBOutlet weak var albumTitleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard isViewLoaded else { return}
        updateViews()
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

//    func addSong(with title: String, duration: String) {
//        albumController.createSong()
//       }
//       
    func updateViews() {
        guard let album = album else { return }
        title = album.name
        artistTextField.text = album.artist
        albumTitleTextField.text = album.name
        
        genreTextField.text = album.genres.joined()
        urlTextField.text = album.coverArt.joined()
      
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    @IBAction func saveAlbumTapped(_ sender: Any) {
        guard let title = albumTitleTextField.text,
            let artist = artistTextField.text,
            let genres = genreTextField.text,
            let covers = urlTextField.text else { return }
        
    }
}
