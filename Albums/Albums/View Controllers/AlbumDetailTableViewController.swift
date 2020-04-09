//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UIViewController, SongTableViewCellDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtTextField: UITextField!
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs = [Song]()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        guard let album = album else { return }
        
        self.title = album.name
        albumNameTextField.text = album.name
        artistTextField.text = album.artist
        genresTextField.text = album.genres.joined(separator: ",")
        let covertArt: String = {
            var tempCoverArt = [String]()
            for coverArt in album.coverArt {
                do {
                    tempCoverArt.append(try String(contentsOf: coverArt.url))
                } catch {
                    print("Failed to convert url to string")
                }
            }
            return tempCoverArt.joined(separator: ",")
        }()
        coverArtTextField.text = String(covertArt)
        
        tempSongs = album.songs
    }
    
    // MARK: - Action Handlers
    
    @IBAction func save(_ sender: Any) {
        guard let name = albumNameTextField.text,
            name.isEmpty == false,
            let artist = artistTextField.text,
            artist.isEmpty == false,
            let genres = genresTextField.text,
            genres.isEmpty == false,
            let coverArt = coverArtTextField.text,
            coverArt.isEmpty == false
            else { return }
        
        if let album = album {
            albumController?.updateAlbum(album: album, artist: artist, coverArt: coverArt, genres: genres, name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: coverArt, genres: genres, id: String(tempSongs.count), name: name, songs: tempSongs)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(title: title, duration: duration) else { return }
        tempSongs.append(song)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .none, animated: true)
    }
}

extension AlbumDetailTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongsTableViewCell else {
            fatalError("Cell did not return as custom cell")
        }
        
        cell.song = tempSongs[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = albumController?.albums[indexPath.row] {
            return 140
        } else {
            return 100
        }
    }
}
