//
//  AlbumDetailsTableViewController.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class AlbumDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album?
    
    var tempSongs: [Song] = [] {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let album = album {
            title = album.name
        } else {
            title = "New Album"
        }
        updateViews()
    }
    
    func updateViews() {
        guard let album = album else { return }
        nameTextfield.text = album.name
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ",")
        urlTextField.text = album.coverArt.absoluteString
        tempSongs = album.songs ?? []
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    
    @IBAction func saveTapped(_ sender: Any) {
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { fatalError(" fail to make song cell")}
        cell.delegate = self
        cell.song = tempSongs[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.row == tempSongs.count {
            return 140
        } else {
            return 100
        }
    }
    
    
}

extension AlbumDetailsTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        if let song = albumController?.createSong(duration: duration, title: title) {
            tempSongs.append(song)
            self.tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .top, animated: true)
        }
    }
}
