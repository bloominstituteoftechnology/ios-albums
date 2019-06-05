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
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(check))
	}
	
	@objc func check() {
		let a = albumController.albums[0]
		albumController.testEncodingExampleAlbum(album: a)
		
	}
	
	let albumController = AlbumController()
}
