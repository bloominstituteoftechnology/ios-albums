//
//  AlbumDetailTableViewController.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/11/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    var albumcontroller: AlbumController?
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs : [Song] = []
    
    // IB Outlets
    @IBOutlet weak var albumNameTxtField: UITextField!
    @IBOutlet weak var artistNameTxtField: UITextField!
    @IBOutlet weak var genresTxtField: UITextField!
    @IBOutlet weak var albumURLSTxtField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - UpdateViews
        // configure views
        func updateViews() {
            //Remember to make sure the view is loaded or the app will crash. isViewLoaded
            guard let album = album, self.isViewLoaded else { return }
            albumNameTxtField.text = album.name
            artistNameTxtField.text = album.artist
    //        genresTxtField.text = "\(album.genres)" // originl Way
            genresTxtField.text = album.genres.joined(separator: ", ")
            albumURLSTxtField.text = "\(album.coverArt)"
            tempSongs = album.songs
            
        }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddSongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.song = nil
        } else {
            cell.song = tempSongs[indexPath.row - 1]
        }
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { // if there are no saved properties need space for Add Album button
            return 140.0
        } else {  // Otherwise the height can be smaller as the add button is not needed
            return 100.0
        }
    }

    
    // IB Actions
    @IBAction func saveBtnWasPressed(_ sender: Any) {
        //Using optional binding, unwrap the text from the text fields.
        guard let name = albumNameTxtField.text, !name.isEmpty,
            let artist = artistNameTxtField.text, !artist.isEmpty,
            let genreString = genresTxtField.text, !genreString.isEmpty,
            let coverURLString = albumURLSTxtField.text, !coverURLString.isEmpty else { return }
        
        let genres = genreString.components(separatedBy: ", ")
        let coverArtURLs = coverURLString.components(separatedBy: ", ").compactMap { URL(string: $0) }
        
        //If there is an album, call the update(album: ...) method,
        //if not, call the createAlbum method using the unwrapped text, and the tempSongs array.
        if let album = album {
            albumcontroller?.update(album: album, id: album.id, name: name, artist: artist, genres: genres, coverArt: coverArtURLs, songs: tempSongs)
        } else {
            albumcontroller?.createAlbum(id: UUID().uuidString, name: name, artist: artist, genres: genres, coverArt: coverArtURLs, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = Song(id: UUID().uuidString, duration: duration, name: title)
        tempSongs.append(song)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}
