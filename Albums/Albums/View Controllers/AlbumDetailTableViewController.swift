//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Kat Milton on 8/5/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    @IBOutlet var albumNameTextField: UITextField!
    @IBOutlet var artistNameTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var coverArtURLTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var songsToAddToAlbum: [Song] = []

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
            albumNameTextField.text = album.name
            artistNameTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ", ")
            let coverArtURLs = album.coverArt.compactMap({ $0.absoluteString})
            coverArtURLTextField.text = coverArtURLs.joined(separator: ", ")
            songsToAddToAlbum = album.songs
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songsToAddToAlbum.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        songCell.delegate = self
        if indexPath.row < songsToAddToAlbum.count {
            songCell.song = songsToAddToAlbum[indexPath.row]
        }
        
        return songCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == songsToAddToAlbum.count ? 140 : 100
    }

    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let title = albumNameTextField.text, !title.isEmpty,
            let artist = artistNameTextField.text, !artist.isEmpty,
            let genresString = genreTextField.text,
            let coverArtURLString = coverArtURLTextField.text else { return }
       
        let genres = genresString.split(separator: ",").map() { String($0) }
        let coverArtURLStrings = coverArtURLString.split(separator: ",").map() { String($0) }
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: coverArtURLs, genres: genres, id: album.id, name: title, songs: songsToAddToAlbum)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: coverArtURLs, genres: genres, id: UUID(), name: title, songs: songsToAddToAlbum)
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let newSong = albumController?.createSong(title: title, duration: duration) else { return }
        songsToAddToAlbum.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: songsToAddToAlbum.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
}
