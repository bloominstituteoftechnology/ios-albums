//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumNameField: UITextField!
    @IBOutlet weak var artistNameField: UITextField!
    @IBOutlet weak var genresField: UITextField!
    @IBOutlet weak var coverURLsField: UITextField!
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableViewCell else { fatalError() }
        cell.delegate = self
        if indexPath.row != tempSongs.count {
                cell.song = tempSongs[indexPath.row]
        }
        
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tempSongs.count {
            return 200
        } else {
            return 140
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Action
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = albumNameField.text,
            !name.isEmpty,
            let artist = artistNameField.text,
            !artist.isEmpty,
            let stringGenres = genresField.text,
            let stringCoverURLs = coverURLsField.text,
        !tempSongs.isEmpty{
            
            let coverArt = stringCoverURLs.components(separatedBy: ",")
            let genres = stringGenres.components(separatedBy: ",")
            
            if let album = album {
                albumController?.update(for: album, artist: artist, coverArt: coverArt, genres: genres, name: name, songs: tempSongs)
            } else {
                albumController?.createAlbum(artist: artist, coverArt: coverArt, name: name, songs: tempSongs, genres: genres)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        guard let album = album else { return }
        DispatchQueue.main.async {
            if self.isViewLoaded {
                self.albumNameField.text = album.name
                self.artistNameField.text = album.artist
                self.genresField.text = album.genres.joined(separator: ",")
                self.coverURLsField.text = album.coverArt.compactMap({ String($0.absoluteString)}).joined(separator: ",")
                self.title = album.name
                self.tempSongs = album.songs
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Protocol
    
    func addSong(duration: String, title: String) {
        if let newSong = albumController?.createSong(duration: duration, title: title) {
            tempSongs.append(newSong)
            tableView.reloadData()
            let indexPath = IndexPath(row: tempSongs.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }
    
}
