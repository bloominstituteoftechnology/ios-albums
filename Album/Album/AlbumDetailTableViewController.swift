//
//  AlbumDetailTableViewController.swift
//  Album
//
//  Created by Christy Hicks on 1/21/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController, SongTableViewCellDelegate {
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album?
    
    //MARK: Outlets
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    private func updateViews() {
        
        guard let album = album, isViewLoaded else { return }
        
        title = album.name
        
        albumNameTextField.text = album.name
        artistNameTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        coverURLsTextField.text = album.coverArt.map({ $0.absoluteString}).joined(separator: ", ")
        albumController?.songList = album.songs
    }
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let name = albumNameTextField.text,
            let artist = artistNameTextField.text,
            let genre = genreTextField.text,
            let coverURLsString = coverURLsTextField.text else { return }
        
        let genres = genre.components(separatedBy: ", ")
        let coverURLs = coverURLsString.components(separatedBy: ", ").compactMap({URL(string: $0) })
        
        if let album = album {
            albumController?.update(album: album, with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: albumController!.songList)
        } else {
            albumController?.createAlbum(with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: albumController!.songList)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Methods
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(with: title, duration: duration) else { return }
        
        albumController?.songList.append(song)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: albumController?.songList.count ?? 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == albumController?.songList.count ? 140 : 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (albumController?.songList.count ?? 0) + 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? SongTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        if indexPath.row < albumController?.songList.count ?? 0 {
            let song = albumController?.songList[indexPath.row]
            
            cell.song = song
        }
        
        return cell
    }
}


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

   
