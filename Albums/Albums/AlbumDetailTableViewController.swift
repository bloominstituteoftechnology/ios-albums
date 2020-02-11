//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Michael on 2/10/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    var tempSongs: [Song] = []
    
    var albumController: AlbumController?
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard
            let name = albumNameTextField.text,
            let artist = artistTextField.text,
            let genre = genreTextField.text,
            let coverArt = URL(string: coverArtURLTextField.text ?? "")
            else { return }
        if let album = album {
            albumController?.update(album: album, artist: artist, coverArt: [coverArt], genres: [genre], name: name, songs: album.songs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: [coverArt], genres: [genre], name: name, songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard
            let genres = album?.genres,
            let coverArt = album?.coverArt
            else { return }
        var coverArtURLs: [String] = []
        var stringGenres = ""
        var stringArt = ""
        if let album = album {
            albumNameTextField.text = album.name
            artistTextField.text = album.artist
            for genre in genres {
                stringGenres = stringGenres + "\(genre)"
                genreTextField.text = "\(genres.joined(separator: "" ))"
            }
            for art in coverArt {
                coverArtURLs.append("\(art)")
                stringArt = stringArt + "\(art)"
                coverArtURLTextField.text = "\(coverArtURLs.joined(separator: "" ))"
            }
            self.title = "\(album.name)"
            tempSongs = album.songs
        } else {
            self.title = "New Album"
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell()}

        cell.delegate = self
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let newSong = albumController?.createSong(duration: title, name: duration) else { return }
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tempSongs.append(newSong)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
