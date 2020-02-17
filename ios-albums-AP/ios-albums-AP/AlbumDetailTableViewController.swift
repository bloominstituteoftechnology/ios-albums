//
//  AlbumDetailTableViewController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var tempSongs: [Song] = []
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        print("save tapped")
        guard let albumName = albumTextField.text, let artistName = artistTextField.text, let genreName = genreTextField.text, let urlName = urlTextField.text, !albumName.isEmpty, !artistName.isEmpty, !genreName.isEmpty, !urlName.isEmpty else {return}
        
        let genres = genreName.components(separatedBy: ", ")
        // turns into URLs
        let coverArts = urlName.components(separatedBy: ", ").compactMap({ URL(string: $0) })
        
        // using the 4 fields either update or create an album
        
        // Detail / Update
        if let album = album {
            albumController?.update(albumToUpdate: album, artist: artistName, coverArt: coverArts, genres: genres, name: albumName, songs: tempSongs)
        }
            
        // Add / Create
        else {
            albumController?.createAlbum(artist: artistName, coverArt: coverArts, genres: genres, name: albumName, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        print("updateViews()")
        guard isViewLoaded else {return}
        if let album = album {
            title = album.name
            albumTextField.text = album.name
            artistTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ", ")
            urlTextField.text = album.coverArt.map({ $0.absoluteString }).joined(separator: ", ")
            tempSongs = album.songs
        }
        else {
            title = "New Album"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1 // So there's an empty cell for the user to add a new song to
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // if last cell, set to 140
        if indexPath.row == tempSongs.count {
            return 140
        } else { return 100}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        // so you don't go out of range
        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            cell.song = song
        }

        return cell
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    
    func addSong(with title: String, duration: String) {
        print("addSong")
        guard let unwrappedSong = albumController?.createSong(title: title, duration: duration) else {return}
        tempSongs.append(unwrappedSong)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .bottom, animated: true)
    }
}
