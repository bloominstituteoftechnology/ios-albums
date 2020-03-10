//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Chris Gonzales on 3/9/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet{
            updateView()
        }
    }
    var tempSongs: [Song] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let name = albumNameTextField.text ?? ""
        let artist = artistTextField.text ?? ""
        let genres = genreTextField.text ?? ""
        let coverArtText = coverArtTextField.text ?? ""
        
        let coverArt = coverArtText.components(separatedBy: "'").compactMap({URL(string: $0)})
        
        if let album = album {
            albumController?.update(album: album,
                                    artist: artist,
                                    coverArt: coverArt,
                                    name: name,
                                    genres: Array(genres.components(separatedBy: ",")),
                                    songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist,
                                         coverArt: coverArt,
                                         name: name,
                                         genres: Array(genres.components(separatedBy: ",")),
                                         songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let album = album else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.albumCellID, for: indexPath)
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
  
    // MARK: - Methods
    
    func updateView() {
        guard let album = album else { return }
        albumNameTextField.text = album.name
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        coverArtTextField.text = album.coverArt.map({ $0.absoluteString}).joined(separator: ",")
        self.title = "New Album"
        tempSongs = album.songs
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let newSong = albumController.createSong(name: title,
                                   duration: duration)
        tempSongs.append(newSong)
        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count,
                                            section: 0),
                              at: .top,
                              animated: true)
        
    }
    
    
}
