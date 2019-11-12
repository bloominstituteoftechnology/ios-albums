//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Bobby Keffury on 10/30/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    var delegate: SongTableViewCellDelegate?
    var albumsTableViewController: AlbumsTableViewController?
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded {
            updateViews()
        } else {
            return
        }
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 160
        } else {
            return 120
        }
    }
    

   
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let albumName = albumNameTextField.text, let artistName = artistNameTextField.text, let genresString = genresTextField.text, let coverURLsString = coverArtURLTextField.text else { return }
        
        let genres = genresString.components(separatedBy: ", ")
        let coverURLs = coverURLsString.components(separatedBy: ", ").compactMap({ URL(string: $0) })
        
        if album != nil {
            albumController?.update(album: album!, artist: artistName, genres: genres, name: albumName, songs: tempSongs)
            self.navigationController?.popViewController(animated: true)
            albumsTableViewController?.tableView.reloadData()
        } else {
            albumController?.createAlbum(with: artistName, coverArt: coverURLs, genres: genres, name: albumName, songs: [])
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    func updateViews() {
        guard let album = album, isViewLoaded else { self.title = "New Album"
            return }
       
            albumNameTextField.text = album.name
            artistNameTextField.text = album.artist
            genresTextField.text = album.genres.joined()
            self.title = album.name
            self.tempSongs = album.songs
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(duration: duration, name: title) else { return }
        tempSongs.append(song)
        tableView.reloadData()
    }
    
    
}


