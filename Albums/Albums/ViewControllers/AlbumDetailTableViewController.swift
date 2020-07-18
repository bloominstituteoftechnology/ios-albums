//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
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
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard isViewLoaded else { return }
        updateViews()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        switch indexPath.row {
        case tempSongs.count:
            return cell
        default:
            cell.song = tempSongs[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 100
        } else {
            return 130
        }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let name = albumNameTextField.text,
            !name.isEmpty,
            let artist = artistTextField.text,
            !artist.isEmpty,
            let genres = genresTextField.text,
            !genres.isEmpty,
            let coverArt = coverURLsTextField.text,
            !coverArt.isEmpty,
            let albumController = albumController {
            if let album = album {
                albumController.update(album: album, name: name, artist: artist, genres: genres.components(separatedBy: ", "), coverArt: coverArt.components(separatedBy: ", "), songs: tempSongs)
            } else {
                albumController.createAlbum(name: name, artist: artist, id: UUID().uuidString, genres: genres.components(separatedBy: ", "), coverArt: coverArt.components(separatedBy: ", "), songs: tempSongs)
            }
            DispatchQueue.main.async {
                albumController.albums = []
                albumController.getAlbums { (result) in
                    DispatchQueue.main.async {
                        print("Refreshed data")
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Please enter album information.", message: "Album fields must not be left blank.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViews() {
        guard self.isViewLoaded else { return }
        if let album = album {
            albumNameTextField.text = album.name
            artistTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ", ")
            coverURLsTextField.text = album.coverArt.joined(separator: ", ")
            tempSongs = album.songs
            title = album.name
        } else {
            title = "New Album"
        }
    }
    
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    
    func addSong(with title: String, duration: String) {
        if let albumController = albumController {
            let song = albumController.createSong(title: title, duration: duration)
            tempSongs.append(song)
            tableView.reloadData()
            let indexPath = IndexPath(row: tempSongs.count, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}
