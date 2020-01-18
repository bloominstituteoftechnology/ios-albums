//
//  AlbumDetailViewController.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController {
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    //MARK: Properties
    
    struct PropertyKeys {
        static let cell = "SongCell"
    }
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []
    
    //MARK: Lifecycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    //MARK: Actions
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let name = albumNameTextField.text,
            let artist = artistNameTextField.text,
            let genre = genreTextField.text,
            let coverArt = urlTextField.text,
            let artURL = URL(string: coverArt) else {return}
        
        if let album = album {
            albumController?.update(album: album, id: album.id, name: name, artist: artist, genres: [genre], coverArt: [artURL], songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Private
    
    
    private func updateViews() {
        
        guard isViewLoaded else {return}
        
        if let album = album {
            albumNameTextField.text = album.name
            artistNameTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ", ")
            urlTextField.text = "\(album.coverArt)"
            tempSongs = album.songs
        }
    }
    
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        }else {
            return 100
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell else {return UITableViewCell()}
        
        // Configure the cell...
        
        cell.delegate = self
        if indexPath.row == 0 {
            cell.song = nil
        }else {
            cell.song = tempSongs[indexPath.row - 1]
        }

        return cell
    }
    

   
}


extension AlbumDetailViewController: SongTableViewCellDelegate {
    
    func addSong(with title: String, duration: String) {
        let song = Song(duration: duration, id: UUID().uuidString, name: title)
        
        tempSongs.append(song)
        tableView.reloadData()
        tableView.scrollToRow(at: [0, tempSongs.count], at: .bottom, animated: true)
    }
    
}
