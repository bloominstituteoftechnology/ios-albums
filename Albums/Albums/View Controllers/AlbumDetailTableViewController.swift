//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Lisa Sampson on 8/31/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isViewLoaded {
        updatesViews()
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let albumName = albumNameLabel.text,
            let artist = artistLabel.text,
            let genre = genreLabel.text,
            let coverArt = coverArtLabel.text else { return }
        
        if let album = album {
            albumController?.update(album: album, albumCover: [coverArt], artist: artist, albumName: albumName, genres: [genre], songs: tempSongs)
        } else {
            albumController?.createAlbum(albumCover: [coverArt], artist: artist, albumName: albumName, genres: [genre], id: UUID().uuidString, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        
        let newSong = albumController.createSong(id: UUID().uuidString, duration: duration, songName: title)
        tempSongs.append(newSong)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updatesViews() {
        
        title = album?.albumName ?? "New Album"
        
        guard let album = album else { return }
        
        albumNameLabel.text = album.albumName
        artistLabel.text = album.artist
        genreLabel.text = album.genres.joined(separator: ", ")
        coverArtLabel.text = album.albumCover.joined(separator: ", ")
        
        tempSongs = album.songs
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        let song = tempSongs[indexPath.row]
        cell.song = song
        cell.delegate = self

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updatesViews()
        }
    }
    var tempSongs: [Song] = []
    
    @IBOutlet weak var albumNameLabel: UITextField!
    @IBOutlet weak var artistLabel: UITextField!
    @IBOutlet weak var genreLabel: UITextField!
    @IBOutlet weak var coverArtLabel: UITextField!
    
}
