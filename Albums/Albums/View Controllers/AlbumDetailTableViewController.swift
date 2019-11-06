//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var txtAlbumName: UITextField!
    @IBOutlet weak var txtArtist: UITextField!
    @IBOutlet weak var txtGenres: UITextField!
    @IBOutlet weak var txtCoverArtURLs: UITextField!
    
    var albumController: AlbumController?
    var album: Album? { didSet { updateViews() } }
    var tempSongs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    func updateViews() {
        guard self.isViewLoaded, let album = album else { return }
        txtAlbumName.text = album.name
        txtArtist.text = album.artist
        txtGenres.text = album.genres.joined(separator: ", ")
        var urlString = ""
        for u in album.coverArt {
            urlString += u.absoluteString + ", "
        }
        if !urlString.isEmpty {
            urlString.removeLast(2)
        }
        txtCoverArtURLs.text = urlString
        tempSongs = album.songs
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        let row = indexPath.row
        if row < tempSongs.count {
            cell.song = tempSongs[row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > tempSongs.count {
            return 140
        } else {
            return 100
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    @IBAction func saveTapped(_ sender: Any) {
        guard let albumName = txtAlbumName.text,
            let artist = txtArtist.text,
            let genres = txtGenres.text,
            let coverArtText = txtCoverArtURLs.text
        else { return }
        
        let coverArtTextArray = coverArtText.components(separatedBy: ", ")
        let coverArtURLs = coverArtTextArray.compactMap({ URL(string: $0) })
        let genresArray = genres.components(separatedBy: ", ")
        
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: coverArtURLs, genres: genresArray, id: album.id, name: albumName, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: coverArtURLs, genres: genresArray, id: UUID(), name: albumName, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        tempSongs.append(albumController.createSong(duration: duration, id: UUID(), title: title))
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .middle, animated: false)
    }
}
