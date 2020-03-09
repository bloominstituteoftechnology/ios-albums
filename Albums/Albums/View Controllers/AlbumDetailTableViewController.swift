//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Vici Shaweddy on 10/30/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtURLTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album? {
        didSet{
            self.updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViews()
    }
    
    private func updateViews() {
        // to make sure the view is loaded before trying to set the values of the outlets or the app will crash
        guard self.isViewLoaded else { return }
        
        if let album = self.album {
            self.title = album.name
            self.albumNameTextField.text = album.name
            self.artistNameTextField.text = album.artist
            self.genresTextField.text = album.genres.joined(separator: ", ").capitalized
            let coverArtsString = album.coverArt.map { $0.absoluteString }
            self.coverArtURLTextField.text = coverArtsString.joined(separator: ", ")
            self.tempSongs = album.songs
        } else {
            self.title = "New Album"
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tempSongs.count + 1
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let title = self.albumNameTextField.text,
              !title.isEmpty,
              let artistName = self.artistNameTextField.text,
              !artistName.isEmpty,
              let genres = self.genresTextField.text,
              let coverArtsString = self.coverArtURLTextField.text else {
                return
        }
        
        let coverArtArray = coverArtsString.components(separatedBy: " ")
        let genresArray = genres.components(separatedBy: " ")
        
        if let album = self.album {
            albumController?.update(with: album, artist: artistName, coverArt: coverArtArray, genres: genresArray, id: album.id, name: title, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artistName, coverArt: coverArtArray, genres: genresArray, id: UUID().uuidString, name: title, songs: tempSongs)
        }
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        
        if indexPath.row != self.tableView.numberOfRows(inSection: 0) - 1 {
            cell.song = tempSongs[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != self.tableView.numberOfRows(inSection: 0) - 1 {
            return 100
        } else {
            return 160
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
        let id = UUID().uuidString
        if let newSong = albumController?.createSong(duration: duration, id: id, name: title) {
            self.tempSongs.append(newSong)
        }
        tableView.reloadData()
        let indexPath = IndexPath(row: self.tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
