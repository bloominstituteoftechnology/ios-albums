//
//  AlbumDetailTableViewController.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//
/**
 In the AlbumDetailTableViewController:

 Create an updateViews method. It should
 Take the appropriate values from the album (if it isn't nil) and place them in the corresponding text fields. You can use the .joined(separator: ...) method to combine the urls and genres into strings.
 Set the title of the view controller to the album's name or "New Album" if the album is nil.
 Set the tempSongs array to the album's array of Songs.
 

 Finally, in the action of the "Save" bar button item:
 Using optional binding, unwrap the text from the text fields.
 If there is an album, call the update(album: ...) method, if not, call the createAlbum method using the unwrapped text, and the tempSongs array.
 Pop the view controller from the navigation controller.
 */
import UIKit

class AlbumDetailTableViewController: UITableViewController {

    var albumController: AlbumController?
    var album: Album? {
        didSet{
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBAction func saveButton(_ sender: Any) {
        guard let name = albumNameTextField.text,
            let artist = albumNameTextField.text,
            let genre = genresTextField.text,
            let coverArt = URLTextField.text else { return }
        if let album = album {
            albumController?.update(for: album, artist: artist, coverArt: coverArt, genres: [genre], id: album.id, name: name, songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, coverArt: coverArt, genres: [genre], id: UUID().uuidString, name: name, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        
        guard isViewLoaded else { return }
        
        if let album = album {
        self.title = album.name
            print(album.name)
        albumNameTextField.text = album.name
        artistNameTextField.text = album.artist
        genresTextField.text = album.genres.joined(separator: ", ")
        URLTextField.text = album.coverArt
        tempSongs = album.songs
        } else {
        
            self.title = "New Album"
                        
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return albumController?.albums.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else {
            return 100
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell else {return UITableViewCell()}

        cell.delegate = self
        if indexPath.row == 0 {
            cell.song = nil
        } else {
            cell.song = tempSongs[indexPath.row - 1]
        }

        return cell
    }
}

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = Song(duration: duration, id: UUID().uuidString, name: title)
        
        tempSongs.append(song)
        tableView.reloadData()
        tableView.scrollToRow(at: [0, tempSongs.count], at: .bottom, animated: true)
    }
    
    
}

