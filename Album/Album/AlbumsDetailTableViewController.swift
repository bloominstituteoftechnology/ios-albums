//
//  AlbumsDetailTableViewController.swift
//  Album
//
//  Created by Lydia Zhang on 4/6/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class AlbumsDetailTableViewController: UITableViewController, songDelegate {
    func addSong(with title: String, duration: String) {
        let song = albumController?.createSong(title: title, duration: duration)
        if let song = song {
            songs.append(song)
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: songs.count, section: 0), at: .top, animated: true)
        }
    }
    

    @IBOutlet weak var albumTitle: UITextField!
    @IBOutlet weak var albumArtist: UITextField!
    @IBOutlet weak var albumGenre: UITextField!
    @IBOutlet weak var albumURL: UITextField!
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    func updateViews() {
        if isViewLoaded {
            if let album = album {
                albumTitle.text = album.name
                albumArtist.text = album.artist
                albumGenre.text = album.genres.joined(separator: ",")
                let urls = album.coverArt.compactMap{ $0.absoluteString }
                albumURL.text = urls.joined(separator: ",")
                title = album.name
                songs = album.songs
            } else {
                title = "New Album"
            }
        }
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count + 1
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = albumTitle.text,
            let artist = albumArtist.text else {return}
        
        let genre = albumGenre.text ?? ""
        let genres = genre.split(separator: ",").compactMap {(String($0))}
        
        let url = albumURL.text ?? ""
        let urls = url.split(separator: ",").compactMap {URL(string: String($0))}
        
        if let album = album {
            albumController?.updateAlbum(album: album, name: name, artist: artist, genres: genres, coverArt: urls, songs: songs)
        } else {
            albumController?.createAlbum(name: name, artist: artist, genres: genres, coverArt: urls, songs: songs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        
        if indexPath.row < songs.count {
            cell.song = songs[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == songs.count {
            return 140
        } else {
            return 100
        }
    }
}
