//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverUrlTextField: UITextField!
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var albumController: AlbumController?
    
    var tempSongs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            if let album = album {
                albumTextField.text = album.name
                artistTextField.text = album.artist
                genreTextField.text = album.genres.joined(separator: ",")
                coverUrlTextField.text = album.coverArt.joined(separator: ",")
                
                title = album.name
                tempSongs = album.songs
            } else {
                title = "New Album"
                tempSongs = []
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = albumTextField.text,
            let artist = artistTextField.text,
            let genresString = genreTextField.text,
            let coverString = coverUrlTextField.text,
            !name.isEmpty,
            !artist.isEmpty,
            !genresString.isEmpty,
            !coverString.isEmpty else { return }
        
        let genres = genresString.components(separatedBy: ",")
        
        let coverArtStrings = coverString.components(separatedBy: ",")
        
        if album != nil {
            albumController?.update(from: &(album)!, artist: artist, coverArt: coverArtStrings, genres: genres, name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: coverArtStrings, genres: genres, name: name, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddSongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        if indexPath.row < tempSongs.count {
            cell.song = tempSongs[indexPath.row]
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= tempSongs.count {
            return 140
        } else {
            return 100
        }
    }

}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addsong(with title: String, duration: String) {
        guard let song = albumController?.createSong(duration: duration, name: title) else { return }
        tempSongs.append(song)
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .none, animated: true)
    }
}
