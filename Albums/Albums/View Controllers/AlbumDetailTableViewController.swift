//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    // MARK: - Properties

    var albumController: AlbumController?
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }

    var tempSongs: [Song] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let albumName = albumNameTextField.text,
            let artist = artistTextField.text,
            let genresString = genresTextField.text,
            let coverURLsString = coverURLsTextField.text else { return }
        
        let genres = genresString.components(separatedBy: ", ")
        let coverArtURLs = coverURLsString.components(separatedBy: ", ").map { URL(fileURLWithPath: $0) }
        
        if let album = album {
            albumController?.update(album: album,
                                    albumName: albumName,
                                    artist: artist,
                                    songs: tempSongs,
                                    coverArt: coverArtURLs,
                                    genres: genres,
                                    id: album.id)
        } else {
            albumController?.createAlbum(albumName: albumName,
                                         artist: artist,
                                         songs: tempSongs,
                                         coverArt: coverArtURLs,
                                         genres: genres,
                                         id: UUID().uuidString)
        }
    }
    
    // MARK: - Private Methods

    private func updateViews() {
        self.title = album?.name ?? "New Album"
        
        if let album = album {
            albumNameTextField.text = album.name
            artistTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ", ")
            let urlStrings = album.coverArtURLs.map { $0.absoluteString }
            coverURLsTextField.text = urlStrings.joined(separator: ", ")
            tempSongs = album.songs
        }
    }
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > tempSongs.count {
            return 140.0
        }
        return 100.0
    }
}

// MARK: - Song TableViewCell Delegate

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = Song(duration: duration, id: UUID().uuidString, title: title)
        tempSongs.append(song)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
