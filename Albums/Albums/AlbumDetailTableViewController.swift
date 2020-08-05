//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Kobe McKee on 6/10/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {

    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []
    
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var albumArtistTextField: UITextField!
    @IBOutlet weak var albumGenreTextField: UITextField!
    @IBOutlet weak var albumCoverArtTextField: UITextField!
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let albumName = albumNameTextField.text,
            let albumArtist = albumArtistTextField.text,
            let albumGenre = albumGenreTextField.text,
            let albumCoverArt = albumCoverArtTextField.text else { return }
        let genreArray = albumGenre.components(separatedBy: ",")
        let coverArtArray = albumCoverArt.components(separatedBy: ",")
        
        if album != nil {
            guard let album = album else { return }
            albumController?.update(album: album, name: albumName, artist: albumArtist, id: album.id, genres: genreArray, coverArt: coverArtArray, songs: tempSongs)
        } else {
            albumController?.createAlbum(name: albumName, artist: albumArtist, id: UUID().uuidString, genres: genreArray, coverArt: coverArtArray, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateViews() {
        
        if album != nil {
            guard let album = album else { return }
            albumNameTextField.text = album.name
            albumArtistTextField.text = album.artist
            albumGenreTextField.text = album.genres.joined(separator: ",")
            albumCoverArtTextField.text = album.coverArt.joined(separator: ",")
            tempSongs = album.songs
            title = album.name
        } else {
            
            title = "New Album"
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded == true {
            updateViews()
        }
    }
    
    func addSong(with title: String, duration: String) {
        let song = albumController?.createSong(name: title, duration: duration, id: UUID().uuidString)
        tempSongs.append(song!)
        tableView.reloadData()
        //let indexPath = tempSong
        //tableView.scrollToRow(at: , at: , animated: )
    }
    

    
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        cell.delegate = self

        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    


}
