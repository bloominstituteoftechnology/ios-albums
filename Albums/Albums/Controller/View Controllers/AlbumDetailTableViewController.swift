//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Chad Rutherford on 1/13/20.
//  Copyright © 2020 chadarutherford.com. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtTextField: UITextField!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs = [Song]()
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private
    private func updateViews() {
        guard let album = album, self.isViewLoaded else { return }
        albumTextField.text = album.name
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        coverArtTextField.text = "\(album.coverArt)"
        tempSongs = album.songs
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = albumTextField.text, !name.isEmpty,
            let artist = artistTextField.text, !artist.isEmpty,
            let genresString = genreTextField.text, !genresString.isEmpty,
            let coverArtString = coverArtTextField.text, !coverArtString.isEmpty else { return }
        let genres = genresString.components(separatedBy: ",")
        let coverArt = coverArtString.components(separatedBy: ",").compactMap { URL(string: $0) }
        
        
        if let album = album {
            albumController?.update(album, id: album.id, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: tempSongs)
        } else {
            albumController?.create(id: UUID().uuidString, name: name, artist: artist, genres: genres, coverArt: coverArt, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.songCell, for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.song = nil
        } else {
            cell.song = tempSongs[indexPath.row - 1]
        }
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else {
            return 100
        }
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = Song(id: UUID().uuidString, name: title, duration: duration)
        tempSongs.append(song)
        tableView.reloadData()
        tableView.scrollToRow(at: [0, tempSongs.count], at: .bottom, animated: true)
    }
}
