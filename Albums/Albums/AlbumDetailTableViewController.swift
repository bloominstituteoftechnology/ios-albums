//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Marissa Gonzales on 5/7/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    @IBOutlet weak var imageURLTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var albumNameTextField: UITextField!
     @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Properties
    
    var tempSongs: [Album.Song] = []
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
         if isViewLoaded {
         guard let album = album else {
             title = "New Album"
             return
         }
         title = album.name
         albumNameTextField.text = album.name
         artistNameTextField.text = album.artist
         genreTextField.text = album.genres.joined(separator: ", ")
         let coverArtURLSTrings = album.coverArtURLs.compactMap({ $0.absoluteString})
            imageURLTextField.text = coverArtURLSTrings.joined(separator: ", ")
         tempSongs = album.songs
         }
     }

   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            
            
        }
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }
}
extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let newSong = albumController.createSong(duration: duration, title: title)
        tempSongs.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
}
