//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    var tempSongs = [Song]()
    
    // MARK: - Outlets

    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func saveAlbum(_ sender: Any) {
        guard let albumName = albumTextField.text,
            let artist = artistTextField.text,
            let genre = genreTextField.text,
            let coverArt = coverArtURLTextField.text else { return }
        
        if let album = album {
            albumController?.update(album: album, albumCover: [coverArt], artist: artist, albumName: albumName, genres: [genre], songs: tempSongs)
        } else {
            albumController?.createAlbum(albumCover: [coverArt], artist: artist, albumName: albumName, genres: [genre], id: UUID().uuidString, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        
        let newSong = albumController.createSong(id: UUID().uuidString, duration: duration, songName: title)
        tempSongs.append(newSong)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateViews() {
        
        title = album?.albumName ?? "New Album"
        
        guard let album = album else { return }
        
        albumTextField.text = album.albumName
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        coverArtURLTextField.text = album.albumCover.joined(separator: ", ")
        
        tempSongs = album.songs
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            cell.song = song
        } else {
            cell.song = nil
        }
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
