//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtURLsTextField: UITextField!
    
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
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = albumNameTextField.text, !name.isEmpty, let artist = artistNameTextField.text, !artist.isEmpty, let genres = genresTextField.text, !genres.isEmpty, let coverArtURLs = coverArtURLsTextField.text, !coverArtURLs.isEmpty else { return }
        let genreArray = genres.components(separatedBy: ", ")
        let coverArtStringArray = coverArtURLs.components(separatedBy: ", ")
        print(coverArtStringArray)
        var coverArtURLsArray: [URL] = []
        for coverArtString in coverArtStringArray {
            if let url = URL(string: coverArtString) {
                coverArtURLsArray.append(url)
            }
            
        }
        
        if let album = album {
            albumController?.createUpdateAlbum(album: album, title: name, artist: artist, genres: genreArray, coverArt: coverArtURLsArray, songs: tempSongs)
        } else {
            albumController?.createUpdateAlbum(album: nil, title: name, artist: artist, genres: genreArray, coverArt: coverArtURLsArray, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }
    
    private func updateViews() {
        if let album = album, isViewLoaded {
            albumNameTextField.text = album.albumTitle
            artistNameTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ", ")
            
            var urlStrings: [String] = []
            for url in album.coverArt {
                let urlString = "\(url)"
                urlStrings.append(urlString)
            }
            
            coverArtURLsTextField.text = urlStrings.joined(separator: ", ")
            
            title = album.albumTitle
            tempSongs = album.songs
        }
        
        title = "New Album"
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        if indexPath.row > 0 {
            cell.song = tempSongs[indexPath.row]
        }
        

        return cell
    }

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
        if let newSong = albumController?.createSong(title: title, duration: duration) {
            tempSongs.append(newSong)
        }
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .none, animated: true)
    }
}
