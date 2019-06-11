//
//  AlbumDetailTableViewCell.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class AlbumDetailTableViewCell: UITableViewCell {

	@IBAction func AddSongButtonPressed(_ sender: Any) {
	
	}
	
	
	func setupViews() {
		guard let song = song else {
			songNameTextField?.isEnabled = true
			songDurationTextField?.isEnabled = true
			return
		}
		
		
		songNameTextField?.text = song.name
		songDurationTextField?.text = song.duration
		
	}
	
	@IBOutlet var songNameTextField: UITextField!
	@IBOutlet var songDurationTextField: UITextField!
	@IBOutlet var addSongButtonOutlet: UIButton!
	
	var song: Song? {
		didSet { setupViews() }
	}
	
}
