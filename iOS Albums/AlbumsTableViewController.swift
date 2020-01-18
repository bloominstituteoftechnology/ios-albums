//
//  AlbumsTableViewController.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    let albumController = AlbumController()
    
    struct PropertyKeys {
        static let cell = "AlbumCell"
        
        static let addSegue = "AddSegue"
        static let detailSegue = "DetailSegue"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //puttingAlbum()

        albumController.getAlbums { error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
//    func puttingAlbum() {
//        let album = Album(artist: "Somebody", coverArt: [URL(string: "343434345432")!], id: "234235235", genres: ["Punk"], name: "Stuff", songs: [Song(duration: "3.44", id: "@34234", name: "A name"), Song(duration: "343", id: "234234", name: "Random Name")])
//        albumController.put(album: album) {
//            print("success")
//        }
//    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cell, for: indexPath)
        cell.textLabel?.text = albumController.albums[indexPath.row].name
        cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.detailSegue {
            guard let detailVC = segue.destination as?
            AlbumDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.albumController = albumController
            detailVC.album = albumController.albums[indexPath.row]
        } else if segue.identifier == PropertyKeys.addSegue {
            guard let addVC = segue.destination as?
                AlbumDetailViewController else { return }
            addVC.albumController = albumController
        }
    }
}
