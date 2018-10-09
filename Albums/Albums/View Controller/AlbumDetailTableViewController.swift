//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    // MARK: - Properties
    
    let reuseIdentifier = "SongTableCell"
    var albumController: AlbumController?
    var album: Album? { didSet { updateViews()}}
    var tempSongs: [Song] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var genre: UITextField!
    @IBOutlet weak var coverURL: UITextField!
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let name = albumName.text,
            let artist = artist.text,
            let genre = genre.text,
            let cover = coverURL.text else { return }
        
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: [cover], genres: [genre], name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: [cover], genres: [genre], name: name, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Update views
    
    func updateViews() {
        if let album = album, isViewLoaded {
            albumName.text = album.name
            artist.text = album.artist
            genre.text = album.genres.joined()
            coverURL.text = album.coverArt.joined()
            tempSongs = album.songs
            
            navigationItem.title = album.name
        } else {
            navigationItem.title = "New Album"
        }
    }
    
    // MARK: - SongTableViewCellDelegate
    
    func addSong(with title: String, duration: String) {
        guard let newSong = albumController?.createSong(duration: duration, name: title) else { return }
        tempSongs.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition(rawValue: indexPath.row)!, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 140
        }
    }
}
