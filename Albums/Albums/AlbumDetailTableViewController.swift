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
    
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
        guard let album = album else {
            title = "New Album"
            return
        }
        
        title = album.name
        albumsNameTextField.text = album.name
        artistNameTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        let coverArtURLStrings = album.coverArt.compactMap({ $0.absoluteString})
        urlsTextField.text = coverArtURLStrings.joined(separator: ", ")
        tempSongs = album.songs
        }
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell

        if indexPath.row < tempSongs.count {
            // If there is a song that corresponds with the cell, pass it to the cell
            let song = tempSongs[indexPath.row]
            cell.song = song
        }
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


   
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // Unwrap all the text fields
        guard let name = albumsNameTextField.text, !name.isEmpty,
            let artist = artistNameTextField.text, !artist.isEmpty,
            let genresString = genreTextField.text,
            let coverArtURLString = urlsTextField.text else { return }
        // Split the genres string into an array
        let genres = genresString.split(separator: ",").map() { String($0) }
        // Split the cover art string into an array and map it into an array of URLs
        let coverArtURLStrings = coverArtURLString.split(separator: ",").map() { String($0) }
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        
        
        if let album = album {
            // If there is an album, update it

            albumController?.update(album: album, artist: artist, coverArt: coverArtURLs, genres: genres, id: album.id, name: name, songs: tempSongs)
        } else {
            // Otherwise, create a new one
            albumController?.createAlbum(artist: artist, coverArt: coverArtURLs, genres: genres, id: UUID().uuidString, name: name, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let newSong = albumController.createSong(title: title, duration: duration)
        tempSongs.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
    
}
