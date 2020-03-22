//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

protocol AlbumDetailTableViewControllerDelegate: class {
    func updatedAlbumDataSource()
}
class AlbumDetailTableViewController: UITableViewController {

    // MARK: - Properties

    var albumController: AlbumController?
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }

    var tempSongs: [Song] = []
    
    weak var delegate: AlbumDetailTableViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let albumName = albumNameTextField.text,
            let artist = artistTextField.text,
            let genresString = genresTextField.text,
            let coverURLsString = coverURLsTextField.text else { return }
        
        let genres = genresString.components(separatedBy: ", ")
        let coverArtURLs = coverURLsString.components(separatedBy: ", ").compactMap { URL(string: $0) }
        
        if let album = album {
            albumController?.update(album: album,
                                    withName: albumName,
                                    artist: artist,
                                    coverArt: coverArtURLs,
                                    genres: genres,
                                    songs: tempSongs)
        } else {
            albumController?.createAlbum(albumName: albumName,
                                         artist: artist,
                                         coverArt: coverArtURLs,
                                         genres: genres,
                                         songs: tempSongs)
        }
        
        delegate?.updatedAlbumDataSource() // Only needed if presented modally
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods

    private func updateViews() {
        self.title = album?.name ?? "New Album"
        
        guard let album = album, isViewLoaded else { return }
        
        albumNameTextField.text = album.name
        artistTextField.text = album.artist
        genresTextField.text = album.genres.joined(separator: ", ")
        coverURLsTextField.text = album.coverArt.map { $0.absoluteString }.joined(separator: ", ")
        tempSongs = album.songs
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == tempSongs.count ? 141.0 : 98.0
    }
}

// MARK: - Song TableViewCell Delegate

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(title: String, duration: String) {
        guard let song = albumController?.createSong(title: title, duration: duration) else { return }
        
        tempSongs.append(song)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateSong(_ song: Song) {
        guard let songIndex = tempSongs.firstIndex(where: { $0.identifier == song.identifier }) else { return }
        
        tempSongs[songIndex].title = song.title
        tempSongs[songIndex].duration = song.duration
    }
}
