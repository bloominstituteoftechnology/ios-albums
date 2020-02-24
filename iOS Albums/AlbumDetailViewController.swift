//
//  AlbumDetailViewController.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController, SongTableViewCellDelegate {
    
    //MARK: Properties
     
//     struct PropertyKeys {
//         static let cell = "SongCell"
//     }
     
     var albumController: AlbumController?
     var album: Album?
     var tempSongs: [Song] = []
     
    
     
    
    //MARK: Lifecycle Methods.
       
       override func viewDidLoad() {
           super.viewDidLoad()
           updateViews()
           
       }
    
    //MARK: Outlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverURLsTextField: UITextField!
    
    
    //MARK: Actions
       
       @IBAction func saveTapped(_ sender: Any) {
           
           guard let name = albumNameTextField.text,
               let artist = artistNameTextField.text,
               let genre = genreTextField.text,
            let coverURLsString = coverURLsTextField.text else {return}
        
        let genres = genre.components(separatedBy: ", ")
        let coverURLs = coverURLsString.components(separatedBy: ", ").compactMap({URL(string: $0) })
        
        if let album = album {
            albumController?.update(album: album, with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
        } else {
            albumController?.createAlbum(with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
        }
           
           navigationController?.popViewController(animated: true)
       }
    
    //MARK: Adding Songs:
    
    func addSong(with title: String, duration: String) {
        guard let song = albumController?.createSong(with: title, duration: duration) else {return}
        
        tempSongs.append(song)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
   
    
    
    //MARK: Private
    
    
    private func updateViews() {
        
        guard let album = album, isViewLoaded else {return}
        
        title = album.name
        
            albumNameTextField.text = album.name
            artistNameTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ", ")
            coverURLsTextField.text = album.coverArt.map({ $0.absoluteString}).joined(separator: ", ")
            tempSongs = album.songs
        }
    
    
    

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == tempSongs.count ? 140 : 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? SongTableViewCell else {return UITableViewCell()}
        
        // Configure the cell...
        
        cell.delegate = self
        if indexPath.row < tempSongs.count {
            let song = tempSongs[indexPath.row]
            
            cell.song = song
        }
        
        return cell
    }
    

   
}


