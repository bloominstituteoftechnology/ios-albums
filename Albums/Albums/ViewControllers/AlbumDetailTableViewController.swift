//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    
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
    
    func updateViews() {
        if isViewLoaded {
            if let album = album {
                albumTextField.text = album.name
                artistTextField.text = album.artist
                genresTextField.text = album.genres.joined(separator: ", ")
                let mapped = album.coverArtURLs.map { $0.absoluteString }
                coverURLsTextField.text = mapped.joined(separator: ", ")
                title = album.name
                tempSongs = album.songs
            } else {
                title = "New Album"
            }
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return SongTableViewCell() }
        
        let index = indexPath.row
        
        if index < tempSongs.count {
           let song = tempSongs[index]
            cell.song = song
        }
        
        cell.delegate = self
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tempSongs.count {
           return 140
        } else {
            return 100
        }
        
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        if let name = albumTextField.text, let artist = artistTextField.text, let genres = genresTextField.text, let urls = coverURLsTextField.text, !name.isEmpty, !artist.isEmpty, !genres.isEmpty, !urls.isEmpty {
            let realGenres = genres.split(separator: ",")
            let cleanGenres = realGenres.compactMap { String($0) }
            let urlStrings = urls.split(separator: ",")
            let URLs = urlStrings.compactMap { URL(string: String($0)) }
            
            if let album = album {
                albumController?.update(album: album, name: name, genres: cleanGenres, artist: artist, coverArtURLs: URLs, songs: tempSongs)
            } else {
                albumController?.createAlbum(name: name, genres: cleanGenres, artist: artist, coverArtURLs: URLs, songs: tempSongs)
            }
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = albumController?.createSong(duration: duration, title: title)
        if let song = song {
            tempSongs.append(song)
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .top, animated: true)
        }
       
        
    }
}
