//
//  AlbumsDetailTableViewController.swift
//  Albums
//
//  Created by Alex Thompson on 1/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AlbumsDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet weak var artistName: UITextField!
    @IBOutlet weak var genre: UITextField!
    @IBOutlet weak var url: UITextField!
    
//    struct PropertyKeys {
//        static let cell = "SongCell"
//    }
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let name = albumName.text,
            let artist = artistName.text,
            let genre = genre.text,
            let coverURlsString = url.text else { return }
        
        let genres = genre.components(separatedBy: ", ")
        let coverURLs = coverURlsString.components(separatedBy: ", ").compactMap({URL(string: $0) })
        
        if let album = album {
            albumController?.update(album: album, with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
        } else {
            albumController?.createAlbum(with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(with: title, duration: duration) else { return }
        
        tempSongs.append(song)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateViews() {
       
        guard let album = album, isViewLoaded else { return }
        
        title = album.name
        
        albumName.text = album.name
        artistName.text = album.artist
        genre.text = album.genres.joined(separator: ", ")
        url.text = album.coverArt.map({$0.absoluteString}).joined(separator: ", ")
        tempSongs = album.songs
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == tempSongs.count ? 140 : 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            
            cell.song = song
        }

        // Configure the cell...

        return cell
    }
}


