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
    }
    
    // MARK: - IBActions & Methods
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    func updateViews() {
        let genreString = ""
        guard let album = album else { return }
        
        albumNameTextField.text = album.name
        artistTextField.text = album.artist
        
        for genre in album.genres {
            
        }
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
