//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Enrique Gongora on 3/9/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        if let song = albumController?.createSong(duration: duration, identifier: UUID().uuidString, name: title) {
            tempSongs.append(song)
        }
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    

    // MARK: - IBOutlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverURLTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let name = albumTextField.text, let artistName = artistTextField.text, let genres = genreTextField.text, let url = coverURLTextField.text else { return }
        if let album = album {
            albumController?.update(album: album, artist: artistName, coverArt: [], genres: [], identifier: UUID().uuidString, name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artistName, coverArt: [], genres: [], identifier: UUID().uuidString, name: name, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Variables
    var tempSongs: [Song] = []
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Functions
    func updateViews() {
        if let album = album {
            albumTextField.text = album.name
            artistTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ",")
            coverURLTextField.text = album.coverArt[0].absoluteString
        }
        navigationItem.title = "New Album"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
