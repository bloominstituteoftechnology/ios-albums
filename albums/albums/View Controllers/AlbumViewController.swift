//
//  AlbumViewController.swift
//  albums
//
//  Created by Hector Steven on 6/3/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = songsTableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
		cell.textLabel?.text = "1"
		return cell
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()
		songsTableView.dataSource = self
		saveRightBarButtonItem()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupViews()
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
	
	func setupViews() {
		guard let album = album else { return }
		
		albumsTextField.text = album.name
		artistTextField.text = album.artist
		
		generesTextField.text = album.genres[0]
		urlsTextField.text = album.coverArt[0]
		
		
	}
	
	
	
	@IBOutlet var songsTableView: UITableView!
	
	@IBOutlet var addSongTitleTextField: UITextField!
	@IBOutlet var addSongDurationTitleTextField: UITextField!
	
	@IBOutlet var albumsTextField: UITextField!
	@IBOutlet var artistTextField: UITextField!
	@IBOutlet var generesTextField: UITextField!
	@IBOutlet var urlsTextField: UITextField!
	
	var album: Album? { didSet{ print("set album") } }
}
