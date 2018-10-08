//
//  AlbumDetailTableViewController.swift
//  iOS Albums
//
//  Created by Dillon McElhinney on 10/8/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    var albumController: AlbumController?
    var album: Album?
    
    var tempSongs: [Song] = []

    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func saveAlbum(_ sender: Any) {
        guard let name = albumNameTextField.text, !name.isEmpty,
        let artist = artistNameTextField.text, !artist.isEmpty,
        let genresString = genresTextField.text,
            let coverArtURLString = coverArtURLTextField.text else { return }
        let genres = genresString.split(separator: ",").map() { String($0) }
        let coverArtURLStrings = coverArtURLString.split(separator: ",").map() { String($0) }
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }
        
        if let album = album {
            albumController?.update(album: album, with: name, artist: artist, genres: genres, coverArtURLs: coverArtURLs, songs: tempSongs)
        } else {
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
    
    // MARK: - Song Table View Cell
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let newSong = albumController.createSong(title: title, duration: duration)
        tempSongs.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
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
