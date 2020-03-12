//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverURLTextField: UITextField!
    
    // MARK: - Properties
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs = [Song]()
    
    private func updateViews() {
        if let album = album {
            self.title = album.name
            if self.isViewLoaded {
                albumTextField.text = album.name
                artistTextField.text = album.artist
                genresTextField.text = album.genres.joined(separator: ",")
                coverURLTextField.text = album.coverArt.joined(separator: ",")
            }
            tempSongs = album.songs
        } else {
            self.title = "New Album"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    @IBAction func saveTapped(sender: UIBarButtonItem) {
        guard let albumString = albumTextField.text,
            let artistString = artistTextField.text,
            let genreString = genresTextField.text,
            let coverURLString = coverURLTextField.text,
            !albumString.isEmpty,
            !artistString.isEmpty,
            !genreString.isEmpty,
            !coverURLString.isEmpty else { return }
        
        if let album = album {
            albumController?.update(for: album, artist: artistString, coverArt: coverURLString.components(separatedBy: ","), genres: genreString.components(separatedBy: ","), id: album.id, name: albumString, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artistString, coverArt: coverURLString.components(separatedBy: ","), genres: genreString.components(separatedBy: ","), id: UUID().uuidString, name: albumString, songs: tempSongs)
        }
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return (section == 0) ? "Songs:" : ""
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 110
        } else {
            return 160
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tempSongs.count) + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        cell.delegate = self
        if indexPath.row < tempSongs.count {
            cell.song = tempSongs[indexPath.row]
        }
        
        return cell
    }

}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        if let albumController = albumController {
            let song = albumController.createSong(duration: duration, id: UUID().uuidString, name: title)
            tempSongs.append(song)
            self.tableView.reloadData()
            let indexPath = IndexPath(row: tempSongs.count, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
