//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Morgan Smith on 5/14/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    @IBOutlet weak var albumTitle: UITextField!
    
    @IBOutlet weak var artistTitle: UITextField!
    
    @IBOutlet weak var genreTitle: UITextField!
    
    @IBOutlet weak var coverArt: UITextField!
    
    
    var albumController: AlbumController?
        var album: Album?
        var tempSongs: [Song] = []
     
     override func viewDidLoad() {
         super.viewDidLoad()
         updateViews()

     }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let name = albumTitle.text,
               let artist = artistTitle.text,
               let genre = genreTitle.text,
            let coverURLsString = coverArt.text else {return}
        
        let genres = genre.components(separatedBy: ", ")
        let coverURLs = coverURLsString.components(separatedBy: ", ").compactMap({URL(string: $0) })
        
        if let album = album {
            albumController?.update(album: album, with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
        } else {
            albumController?.createAlbum(with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
        }
           
           navigationController?.popViewController(animated: true)
    }
    
    func addSong(with title: String, duration: String) {
           guard let song = albumController?.createSong(with: title, duration: duration) else {return}
           
           tempSongs.append(song)
           tableView.reloadData()
           
           let indexPath = IndexPath(row: tempSongs.count, section: 0)
           tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
       }

    private func updateViews() {
    
    guard let album = album, isViewLoaded else {return}
    
    title = album.name
    
        albumTitle.text = album.name
        artistTitle.text = album.artist
        genreTitle.text = album.genres.joined(separator: ", ")
        coverArt.text = album.coverArt.map({ $0.absoluteString}).joined(separator: ", ")
        tempSongs = album.songs
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == tempSongs.count ? 140 : 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return tempSongs.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else {return UITableViewCell()}
            
            cell.delegate = self
            if indexPath.row < tempSongs.count {
                let song = tempSongs[indexPath.row]
                
                cell.song = song
            }

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
