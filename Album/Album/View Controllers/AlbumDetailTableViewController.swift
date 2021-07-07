//
//  AlbumDetailTableViewController.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var albumNameTF: UITextField!
    @IBOutlet weak var artistNameTF: UITextField!
    @IBOutlet weak var genresTF: UITextField!
    @IBOutlet weak var coverArtURLsTF: UITextField!
    
    //MARK: - Properties
    var albumController: AlbumController?
    var album: Album?{
        didSet{
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    let debug: Bool = false
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard   let albumName = albumNameTF.text, !albumName.isEmpty,
                let artistName = artistNameTF.text, !artistName.isEmpty,
                let albumController = albumController
        else { return }
        let genres = genresTF.text ?? ""
        let genresArray = genres.split(separator: ",")
        let genresStringArray = genresArray.map { String($0)}
        let coverArtURLs = coverArtURLsTF.text ?? ""
        let caArray = coverArtURLs.split(separator: ",")
        let caURLArray = caArray.map { URL(string: String($0))!}
        if let album = album {
            albumController.update(album: album, artist: artistName, coverArt: caURLArray, genres: genresStringArray, name: albumName)
        } else {
            albumController.create(artist: artistName, coverArt: caURLArray, genres: genresStringArray, name: albumName, songs: tempSongs)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        if let album = album {
            albumNameTF.text = album.name
            artistNameTF.text = album.artist
            genresTF.text = album.gengresString
            coverArtURLsTF.text = album.coverArtString
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let album = album {
            return album.songs.count + 1
        } else {
            return tempSongs.count + 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell()}
        if let album = album {
            cell.delegate = self
            if indexPath.row <= album.songs.count - 1 {
                cell.song = album.songs[indexPath.row]
            }
        } else {
            cell.delegate = self
            if indexPath.row <= tempSongs.count - 1 {
                cell.song = tempSongs[indexPath.row]
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let album = album {
            if debug {print ("album.songs.count = \(album.songs.count)   indexPath.row = \(indexPath.row)")}
            if indexPath.row == album.songs.count {
                return 120
            } else {
                return 44
            }
        } else {
            if debug {print ("tempSongs.count = \(tempSongs.count)   indexPath.row = \(indexPath.row)")}
            if indexPath.row == tempSongs.count {
                return 120
            } else {
                return 44
            }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        tempSongs.append(albumController.createSong(name: title, duration: Song.durationToSeconds(duration)))
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .bottom, animated: true)
    }
}
