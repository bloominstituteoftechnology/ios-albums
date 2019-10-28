//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var artURLsTextFiled: UITextField!
    
    //MARK: Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            if let album = album {
                nameTextField.text = album.name
                artistTextField.text = album.artist
                genresTextField.text = album.genres.joined(separator: ",")
                artURLsTextFiled.text = album.coverArt.map({ $0.absoluteString }).joined(separator: ",")
                
                title = album.name
                
                tempSongs = album.songs
            } else {
                title = "New Album"
                tempSongs = []
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        if indexPath.row < tempSongs.count {
            cell.song = tempSongs[indexPath.row]
        }

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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= tempSongs.count {
            return 140
        } else {
            return 100
        }
    }

    //MARK: Actions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
            let artist = artistTextField.text,
            let genresString = genresTextField.text,
            let artURLsString = artURLsTextFiled.text,
            !name.isEmpty,
            !artist.isEmpty,
            !genresString.isEmpty,
            !artURLsString.isEmpty else { return }
        
        let genres = genresString.components(separatedBy: ",")
        
        let artURLStrings = artURLsString.components(separatedBy: ",")
        let artOptionalURLs = artURLStrings.map({ URL(string: $0) })
        let artURLs = artOptionalURLs.compactMap({ $0 })
        
        if album != nil {
            albumController?.update(from: &(album)!, artist: artist, coverArt: artURLs, genres: genres, name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: artURLs, genres: genres, name: name, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: Song Table View Cell Delegate

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(duration: duration, name: title) else { return }
        tempSongs.append(song)
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .none, animated: true)
    }
}
