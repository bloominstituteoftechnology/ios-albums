//
//  AlbumDetailViewController.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController {
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []
    
    @IBOutlet weak var albumNameField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var genresField: UITextField!
    @IBOutlet weak var coverURLsField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        albumNameField.text = album?.name
        artistField.text = album?.artist
        genresField.text = album?.genres.joined(separator: ",")
        if let coverArtURLs = album?.coverArtURLs {
            let coverArtStrings = coverArtURLs.map { $0.absoluteString }
            coverURLsField.text = coverArtStrings.joined(separator: ",")
        }
        title = album?.name ?? "New Album"
        tempSongs = album?.songs ?? tempSongs
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

        let index = indexPath.row
        
        cell.delegate = self
        cell.song = index == tempSongs.count ? tempSongs[index] : nil

        return cell
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
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
