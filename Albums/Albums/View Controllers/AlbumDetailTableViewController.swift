//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var urlsTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = albumTextField.text,
            let artist = artistTextField.text,
            let genresSubstrings = genresTextField.text?.split(separator: ","),
            let urlsStrings = urlsTextField.text?.split(separator: ",")
            else {
                return
        }
        
        var urls: [URL] = []
        for string in urlsStrings {
            if let url = URL(string: String(string)) {
                urls.append(url)
            }
        }
        
        var genres: [String] = []
        for genre in genresSubstrings {
            genres.append(String(genre))
        }
        
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: urls, genres: genres, id: "\(UUID())", name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: urls, genres: genres, id: "\(UUID())", name: name, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded {
            updateViews()
        }
    }
    
    func updateViews() {
        if let album = album {
            albumTextField.text = album.name
            artistTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ", ")
            
            var coverArtArray: [String] = []
            for url in album.coverArt {
                let tempString = "\(url)"
                coverArtArray.append(tempString)
            }
            
            urlsTextField.text = coverArtArray.joined(separator: ", ")
            title = album.name
            tempSongs = album.songs
        } else {
            title = "New Album"
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        if indexPath.row < tempSongs.count {
            cell.song = tempSongs[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < tempSongs.count {
            return 100
        } else {
            return 140
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
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(wth title: String, duration: String) {
        let uuid = UUID()
        let id = "\(uuid)"
        let newSong = albumController?.createSong(duration: duration, id: id, name: title)
        
        if let newSong = newSong {
            tempSongs.append(newSong)
        }
        tableView.reloadData()
        var indexPath = IndexPath()
        indexPath.section = 0
        indexPath.row = tempSongs.count
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    
}
