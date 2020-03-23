//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Songs] = []
    
    // MARK: - Outlets
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var genres: UITextField!
    @IBOutlet weak var URLs: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let name = albumName.text,
            let artist = artist.text,
            let genres = genres.text,
            let URLs = URLs.text else { return }
        
        if album == nil {
            albumController?.createAlbum(with: artist, coverArt: URLs, genres: genres, name: name)
        } else {
            albumController?.updateAlbum(album: album!, artist: artist, coverArt: URLs, genres: genres, name: name)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        guard let name = album?.name,
            let artist1 = album?.artist,
            let genres1 = album?.genres,
            let URLs1 = album?.coverArt else { return }
        
        albumName.text = name
        artist.text = artist1
        genres.text = genres1
        URLs.text = URLs1
        
        if self.title == nil {
            self.title = "New Album"
        } else {
            self.title = name
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songInfo", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= tempSongs.count - 1 {
            return 140
        } else {
            return 100
        }
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let newSong = albumController?.createSong(with: duration, name: title) else { return }
        tempSongs.append(newSong)
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .none, animated: true)
    }
}
