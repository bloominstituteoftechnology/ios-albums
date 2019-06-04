//
//  AlbumsTableViewController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		albumController.testDecodingExampleAlbum()
//		if !albumController.albums[0].songs.isEmpty {
//			for song in albumController.albums[0].songs {
//				print(song, "\n")
//			}
//		}
		//print(albumController.albums)
	}
	
	
	
	let albumController = AlbumController()
}
