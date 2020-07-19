//
//  AlbumDetailViewController.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController {
  
  //MARK:- IBOutlets
  
  @IBOutlet weak var albumNameTextField: UITextField!
  @IBOutlet weak var artistNameTextField: UITextField!
  @IBOutlet weak var genresTextField: UITextField!
  @IBOutlet weak var urlTextField: UITextField!
  
  //MARK:- Properties
  
  var albumController: AlbumController?
  var album: Album? {  didSet { updateViews() } }
  private var tempSongs: [Song] = []
  
  //MARK:- Actions
  
  @IBAction func saveTapped(_ sender: UIBarButtonItem) {
    guard let name = albumNameTextField.text,
      let artistName = artistNameTextField.text,
      let genres = genresTextField.text,
      let url = urlTextField.text else { return }
    let arrayGenres = genres.components(separatedBy: ",")
    let arrayURL = url.components(separatedBy: ",").compactMap { URL(string: $0) }
    
    if let album = album {
      albumController?.update(album: album, artist: artistName, coverArt:arrayURL, genres: arrayGenres, id: UUID().uuidString, name: name, songs: tempSongs)
    } else {
      albumController?.createAlbum(artist: artistName, coverArt: arrayURL, genres:arrayGenres, id: UUID().uuidString, name: name, songs: tempSongs)
    }
    navigationController?.popViewController(animated: true)
  }
  
  
  //MARK:- View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    albumNameTextField.becomeFirstResponder()
    updateViews()
  }
  
  func updateViews() {
    guard isViewLoaded else { return }
    if let album = album {
      albumNameTextField.text = album.name
      artistNameTextField.text = album.artist
      genresTextField.text = album.genres.joined(separator: ",")
      urlTextField.text = album.coverArt.map { $0.absoluteString}.joined()
      tempSongs = album.songs
      
    }
    navigationItem.title = "New Album"
    
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tempSongs.count + 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Helper.songTableCell, for: indexPath) as! SongTableCell
    cell.delegate = self
    
    switch indexPath.row {
      case tempSongs.count: // Last index will remain two textfield
        break
      default:
        cell.song = tempSongs[indexPath.row]
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.row == 0 ? 200 : 240
  }
}
extension AlbumDetailViewController: SongTableCellDelegate {
  
  func didAddSong(with title: String, duration: String) {
    if let song = albumController?.createSong(duration: duration, id: UUID().uuidString, name: title) {
      tempSongs.append(song)
      
      
      let indexPath = IndexPath(row: tempSongs.count, section: 0)
      tableView.reloadData()
      tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
  }
}
