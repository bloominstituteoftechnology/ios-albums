//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
        let artist = artistTextField.text,
        let genres = genresTextField.text,
            let urls = urlsTextField.text else { return }
        
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: URL(string: "\(urls)"), genres: genres, id: album.id, name: title)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: URL(string: "\(urls)"), genres: genres, name: title, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        guard let songCell = cell as? SongTableViewCell,
        let index = tableView.indexPathForSelectedRow else { return cell }
        songCell.song = album!.songs![index.row]
        songCell.delegate = self
        return songCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    private func updateViews() {
        guard let album = album else {
            navigationItem.title = "New Album"
            return }
        navigationItem.title = album.name
        guard let title = titleTextField,
            let artist = artistTextField,
            let genres = genresTextField,
            let urls = urlsTextField else { return }
        
        title.text = album.name
        artist.text = album.artist
        genres.text = album.genres.joined(separator: ", ")
        urls.text = album.coverArt?.absoluteString
        if let songs = album.songs {
            tempSongs = songs
        }
    }
    
    func addSong(with title: String, duration: String) {
        let song = albumController?.createSong(name: title, duration: duration)
        tempSongs.append(song!)
        tableView.reloadData()
        
        let index = IndexPath(row: album!.songs!.count, section: 0)
        tableView.scrollToRow(at: index, at: .middle, animated: true)
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var urlsTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
}
