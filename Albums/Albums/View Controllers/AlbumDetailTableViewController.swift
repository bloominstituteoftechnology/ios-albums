//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Jake Connerly on 9/30/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UIViewController {
    
    // MARK: - IBOutlets & Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var albumArtUrlTextField: UITextField!
    
    var albumController: AlbumController?
    var album: Album?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateViews()
    }
    
    // MARK: - IBActions & Methods
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews() {
        var genreString = ""
        var albumArtString = ""
        guard let album = album else { return }
        for genre in album.genres {
            genreString.append(genre + ",")
        }
        
        for art in album.coverArt {
            let artString = "\(art)"
            albumArtString.append(artString + ",")
        }
        
        albumNameTextField.text = album.name
        artistTextField.text = album.artist
        genreTextField.text = genreString
        albumArtUrlTextField.text = albumArtString
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

// MARK: - Extensions

extension AlbumDetailTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let album = album else { return 0 }
        return album.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        if let album = album {
            cell.songTitleTextField.text    = album.songs[indexPath.row].name
            cell.songDurationTextField.text = album.songs[indexPath.row].duration
        }
        return cell
    }
    
    
}
