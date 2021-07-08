//
//  AlbumsDetailTableViewController.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class AlbumsDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let album = album else { return 0 }
        return album.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? AlbumsDetailTableViewCell else {fatalError("Unable to dequeue cell as AlbumsDetailTableViewCell")}
        guard let album = album else { fatalError("Not album set.")}
        
        let song = album.songs[indexPath.row]
        
        cell.songTitleTextField.text = song.name
        cell.songTitleTextField.text = song.duration
        // Configure the cell...

        return cell
    }
    
    @IBAction func save(_ sender: Any) {
        
        if let album = album {
            guard let albumController = albumController else {fatalError("Not album set.")}
            
            album.name = albumNameTextField.text ?? ""
            album.artist = artistNameTextField.text ?? ""
            album.genres = [genreNameTextField.text ?? ""]
            album.coverArtURLs = [URL(string: coverImageURLsTextField.text!)!]
            for song in album.songs{
                album.songs.append(song)
            }
            albumController.updateAlbum(album: album, name: album.name, artist: album.artist, coverArtURLs: album.coverArtURLs, genres: album.genres, songs: album.songs)
        
        } else {
            guard let albumController = albumController else {fatalError("Not album set.")}
    
            albumController.createAlbum(
                name: albumNameTextField.text ?? "",
                artist: artistNameTextField.text ?? "",
                genres: [genreNameTextField.text ?? ""], coverArtURLs: [URL(string: coverImageURLsTextField.text ?? "https://www.google.com")!])
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSong(_ sender: Any) {
        
    }
    
    func updateViews(){
        guard let album = album else { return }
        
        albumNameTextField.text = album.name
        artistNameTextField.text = album.artist
        var genreString: String = ""
        for genre in album.genres {
             genreString = "\(genre), "
        }
        genreNameTextField.text = genreString
        
        genreNameTextField.text = album.genres.first
        album.coverArtURLs = [URL(string: coverImageURLsTextField.text!)!]
    
    }
    
    // MARK: - Properties
    var album: Album?
    var albumController: AlbumController?
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genreNameTextField: UITextField!
    @IBOutlet weak var coverImageURLsTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
}
