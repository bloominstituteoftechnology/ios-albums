//
//  AlbumDetailTableViewController.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    // MARK: - Properties
    var albumController: AlbumController?
    var album: Album?
    
    var tempSongs: [Song] = []

    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - UI Methods
    @IBAction func saveAlbum(_ sender: Any) {
        // Unwrap all the text fields
        guard let name = albumNameTextField.text, !name.isEmpty,
        let artist = artistNameTextField.text, !artist.isEmpty,
        let genresString = genresTextField.text,
            let coverArtURLString = coverArtURLTextField.text else { return }
        // Split the genres string into an array
        let genres = genresString.split(separator: ",").map() { String($0) }
        // Split the cover art string into an array and map it into an array of URLs
        let coverArtURLStrings = coverArtURLString.split(separator: ",").map() { String($0) }
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        
        
        if let album = album {
            // If there is an album, update it
            albumController?.update(album: album, with: name, artist: artist, genres: genres, coverArtURLs: coverArtURLs, songs: tempSongs)
        } else {
            // Otherwise, create a new one
            albumController?.createAlbum(name: name, artist: artist, genres: genres, coverArtURLs: coverArtURLs, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
        
        if indexPath.row < tempSongs.count {
            // If there is a song that corresponds with the cell, pass it to the cell
            let song = tempSongs[indexPath.row]
            cell.song = song
        }
        
        // Set the cell's delegate no matter what
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 80
        } else {
            return 120
        }
    }
    
    // MARK: - Song Table View Cell
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let newSong = albumController.createSong(title: title, duration: duration)
        tempSongs.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
    // MARK: - Utility Methods
    private func updateViews() {
        guard let album = album else {
            title = "New Album"
            return
        }
        
        title = album.name
        albumNameTextField.text = album.name
        artistNameTextField.text = album.artist
        genresTextField.text = album.genres.joined(separator: ", ")
        let coverArtURLStrings = album.coverArtURLs.compactMap() { $0.absoluteString }
        coverArtURLTextField.text = coverArtURLStrings.joined(separator: ", ")
        tempSongs = album.songs
    }
}
