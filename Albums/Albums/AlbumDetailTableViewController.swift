//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let newSong = albumController.createSong(name: title, duration: duration)
        tempSongs.append(newSong)
        tableView.reloadData()
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    


}

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func saveButtonPressed(_ sender: Any) {

        guard let name = albumNameTextField.text, !name.isEmpty,
            let artist = artistTextField.text, !artist.isEmpty,
            let genresString = genresTextField.text,
            let coverArtURLString = imagesTextField.text else { return }
        let genres = genresString.split(separator: ",").map() { String($0) }

        let coverArtURLStrings = coverArtURLString.split(separator: ",").map() { String($0) }
        let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }


        if let album = album {
            // If there is an album, update it

            albumController?.update(album: album, artist: artist, coverArt: coverArtURLs, genres: genresString, id: album.id, name: name, songs: tempSongs)
        } else {
            // Otherwise, create a new one
            albumController?.createAlbum(artist: artist, coverArt: coverArtURLs, genres: genresString, name: name, songs: tempSongs)
        }

        navigationController?.popViewController(animated: true)


    }
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        if indexPath.row < tempSongs.count {

            let song = tempSongs[indexPath.row]
            cell.song = song
        }
        cell.delegate = self


        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 80
        } else {
            return 120
        }
    }

    func updateViews() {
        if isViewLoaded {
            guard let album = album,
                let songs = album.songs else {
                title = "New Album"
                return
            }

            title = album.name
            albumNameTextField.text = album.name
            artistTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ", ")
            let coverArtURLStrings = album.coverArt.compactMap({ $0.absoluteString})
            imagesTextField.text = coverArtURLStrings.joined(separator: ", ")
            tempSongs = songs
        }
    }

    @IBOutlet weak var albumNameTextField: UITextField!

    @IBOutlet weak var artistTextField: UITextField!

    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var imagesTextField: UITextField!
    var albumController: AlbumController?
    var album: Album?
    var tempSongs: [Song] = [] {
        didSet {
            updateViews()
        }
    }
}
