//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    var tempSongs = [Song]()
    
    

    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func saveAlbum(_ sender: Any) {
        guard let albumName = albumTextField.text,
            let artist = artistTextField.text,
            let genre = genreTextField.text,
            let coverArt = coverArtURLTextField.text else { return }
        
        if let album = album {
            albumController?.update(album: album, albumCover: [coverArt], artist: artist, albumName: albumName, genres: [genre], songs: tempSongs)
        } else {
            albumController?.createAlbum(albumCover: [coverArt], artist: artist, albumName: albumName, genres: [genre], id: UUID().uuidString, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        
        let newSong = albumController.createSong(id: UUID().uuidString, duration: duration, songName: title)
        tempSongs.append(newSong)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateViews() {
        
        title = album?.albumName ?? "New Album"
        
        guard let album = album else { return }
        
        albumTextField.text = album.albumName
        artistTextField.text = album.artist
        genreTextField.text = album.genres.joined(separator: ", ")
        coverArtURLTextField.text = album.albumCover.joined(separator: ", ")
        
        tempSongs = album.songs
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            cell.song = song
        } else {
            cell.song = nil
        }
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
