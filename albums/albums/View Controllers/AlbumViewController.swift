//
//  AlbumViewController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
		
		saveRightBarButtonItem()
	}

	@objc func save() {
		
	}
	
	func saveRightBarButtonItem() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
	}
	
	@IBAction func AddSongButtonAction(_ sender: Any) {
		guard let title = addSongTitleTextField.text,
			let duration = addSongDurationTitleTextField.text else { return }
	
		print(title, duration)
	}
	
	
	@IBOutlet var songsTableView: UITableView!
	
	@IBOutlet var addSongTitleTextField: UITextField!
	@IBOutlet var addSongDurationTitleTextField: UITextField!
	
	@IBOutlet var albumsTextField: UITextField!
	@IBOutlet var artistTextField: UITextField!
	@IBOutlet var generesTextField: UITextField!
	@IBOutlet var urlsTextField: UITextField!
}
