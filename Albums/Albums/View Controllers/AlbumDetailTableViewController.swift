//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    @IBOutlet weak var albumTitleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreListTextField: UITextField!
    @IBOutlet weak var artURLSTextField: UITextField!
    
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

    @IBAction func saveAlbumButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    func updateViews() {
        guard let album = album else { return }
        albumTitleTextField.text = album.name
        artistTextField.text = album.artist
        genreListTextField.text = album.genres.joined(separator: ", ")
        
        //artURLSTextField.text = album.coverArt.joined(separator: ", ") parsing cover art must be handled differently based on strings
        
        title = album.name
        tempSongs = album.songs
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
            as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = tableView.rowHeight
        height = UITableView.automaticDimension
        return height
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        if let song = albumController?.createSong(id: "", name: title, duration: duration) {
            tempSongs.append(song)
        }
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .bottom, animated: true)
    }
}
