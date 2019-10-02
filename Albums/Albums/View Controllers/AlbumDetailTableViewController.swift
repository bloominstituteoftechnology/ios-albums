//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var genres: UITextField!
    @IBOutlet weak var coverArtURLs: UITextField!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let name = albumName.text,
            let artist = artist.text,
            let genres = genres.text,
            let coverArtURLs = coverArtURLs.text else { return }
        
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: coverArtURLs, genres: genres, id: name, name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: coverArtURLs, genres: genres, id: name, name: name, songs: tempSongs)
        }
    }
    
    func updateViews() {
        if let album = album {
            albumName.text = album.name
            artist.text = album.artist
            genres.text = "\(album.genres)"
            coverArtURLs.text = "\(album.coverArt)"
            navigationController?.title = album.name
            tempSongs = album.songs
        } else {
            navigationController?.title = "New Album"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded {
            updateViews()
        }
    }
    
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(duration: duration, id: title, name: title) else { return }
        tempSongs.append(song)
        tableView.reloadData()
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = tempSongs.count + 1
        return rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(140.00)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        return cell
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

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
