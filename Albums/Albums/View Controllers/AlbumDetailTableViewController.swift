//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let albumName = albumNameTextField.text, !albumName.isEmpty, let artistName = artistNameTextField.text, !artistName.isEmpty, let genres = genresTextField.text, !genres.isEmpty, let coverURLS = coverURLsTextField.text, !coverURLS.isEmpty else { return }
        
        let genresSeperated = genres.components(separatedBy: ",")
        let coverURLsSeperated = coverURLS.components(separatedBy: ",")
        
        if let album = album {
            albumController?.update(album: album, id: album.id, name: albumName, artist: artistName, genres: genresSeperated, coverArt: coverURLsSeperated, songs: tempSongs)
        } else {
            let uuid = UUID()
            albumController?.createAlbum(id: uuid.uuidString, name: albumName, artist: artistName, genres: genresSeperated, coverArt: coverURLsSeperated, songs: tempSongs)
        }
        
        
        navigationController?.popViewController(animated: true)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Songs"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tempSongs.count {
            return 140
        } else {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        if indexPath.row < tempSongs.count {
            cell.song = tempSongs[indexPath.row]
        }

        return cell
    }
    
    private func updateViews() {
        if let album = album {
            
            title = album.name
            tempSongs = album.songs
            if isViewLoaded {
                albumNameTextField.text = album.name
                artistNameTextField.text = album.artist
                let genres = album.genres.joined(separator: ",")
                let coverURLs = album.coverArt.joined(separator: ",")
                genresTextField.text = genres
                coverURLsTextField.text = coverURLs
            }
        } else {
            title = "New Album"
        }
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let id = UUID()
        let song = albumController?.createSong(duration: duration, id: id.uuidString, name: title)
        tempSongs.append(song!)
        tableView.reloadData()        
        tableView.scrollToRow(at: IndexPath(item: tempSongs.count, section: 0), at: .middle, animated: true)
    }
}
