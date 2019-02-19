//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let artist = artistName.text, !artist.isEmpty,
            let name = albumName.text, !name.isEmpty,
            let genresString = genresTextField.text,
            let coverArtString = coverArtTextField.text else { return }
        
        let genres = genresString.split(separator: ",").map() { String($0) }
        let coverArtArray = coverArtString.split(separator: ",").map() { String($0) }
        let coverArt = coverArtArray.compactMap() { URL(string: $0) }
        
        if let album = album {
            albumController?.update(album: album, artist: artist, name: name, genres: genres, coverArt: coverArt, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, name: name, genres: genres, coverArt: coverArt, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if isViewLoaded {
            guard let album = album else {
                title = "New Album"
                return }
            
            title = "Album:"
            albumName.text = album.name
            artistName.text = album.artist
            genresTextField.text = album.genres.map({ $0 }).joined(separator: ", ")
            coverArtTextField.text = album.coverArt.map({ $0.absoluteString }).joined(separator: ", ")
            tempSongs = album.songs
        }
    }
    
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(name: title, duration: duration) else { return }
        tempSongs.append(song)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tempSongs.count + 1
    }
    
    let reuseIdentifier = "SongCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SongTableViewCell
        
        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            cell.song = song
        }
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 90
        } else {
            return 130
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []
    
    @IBOutlet var albumName: UITextField!
    @IBOutlet var artistName: UITextField!
    @IBOutlet var genresTextField: UITextField!
    @IBOutlet var coverArtTextField: UITextField!
}
