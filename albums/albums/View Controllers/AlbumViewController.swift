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
	
	func saveRightBarButtonItem() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
	}
	
	@objc func save() {
		
	}
	
	@IBOutlet var albumsTextField: UITextField!
	@IBOutlet var artistTextField: UITextField!
	
	@IBOutlet var generesTextField: UITextField!
	@IBOutlet var urlsTextField: UITextField!
}
