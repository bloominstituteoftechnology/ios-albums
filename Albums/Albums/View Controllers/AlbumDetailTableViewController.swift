//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {

    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    // MARK: - Outlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtTextField: UITextField!

    // MARK: - Actions
    @IBAction func saveButton(_ sender: Any) {
        
        if album != nil {
            albumController?.update(album: album!,
                                    albumTitle: albumTextField?.text ?? "",
                                    artist: artistTextField?.text ?? "",
                                    genres: genreTextField.text ?? "",
                                    coverArt: coverArtTextField.text ?? "",
                                    songs: tempSongs)
        } else {
            albumController?.create(album: albumTextField?.text ?? "",
                                    artist: artistTextField?.text ?? "",
                                    genres: genreTextField?.text ?? "",
                                    coverArt: coverArtTextField?.text ?? "")
            
        }

        // Use this if you present modally
        //dismiss(animated: true, completion: nil)
        
        // Use this if you Show
        // TODO: Should I call it here or should the caller do it?
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func addSong(with title: String, duration: String) {
        guard let album = album else { return }
        let newSong = albumController?.createSong(album: album, title: title, duration: duration)
        
        guard let songToAdd = newSong else { return }
        tempSongs.append(songToAdd)
        
        tableView.reloadData()

        // TODO: ? Terminating app due to uncaught exception 'NSRangeException', reason: 'Attempted to scroll the table view to an out-of-bounds row (1) when there are only 1 rows in section 0.
        tableView.scrollToRow(at: IndexPath(item: tempSongs.count, section: 0), at: .bottom, animated: true)
    }
    
    private func updateViews() {
        if let album = album {
            title = album.album
            albumTextField?.text = album.album
            artistTextField?.text = album.artist
            genreTextField?.text = album.genres
            coverArtTextField?.text = album.coverArt // TODO: ? At what level? .joined(separator: ...)
            tempSongs = album.songs
            
        } else {
            title = "New Album"
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        // Configure the cell...
        cell.delegate = self
        if indexPath.row < tempSongs.count {
            cell.song = tempSongs[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Songs"
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 100
        } else {
            return 140
        }
    }
    
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
}
