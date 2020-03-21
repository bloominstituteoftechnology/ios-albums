//
//  AlbumDetailTableViewCell.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

protocol AlbumDetailTableViewCellDelegate: AnyObject {
	func updateSongs(song: Song)
}


class AlbumDetailTableViewCell: UITableViewCell {

	@IBAction func AddSongButtonPressed(_ sender: Any) {
		guard let name = songNameTextField.text,
			let duration = songDurationTextField.text else { return }
		let song = Song(name: name, duration: duration)
		
		delegate?.updateSongs(song: song)
	}
	
	
	func setupViews() {
		guard let song = song else {
			songNameTextField?.isEnabled = true
			songDurationTextField?.isEnabled = true
			addSongButtonOutlet?.isHidden = false
			songNameTextField?.text = ""
			songDurationTextField?.text = ""
			return
		}
		
		addSongButtonOutlet?.isHidden = true
		songNameTextField?.text = song.name
		songDurationTextField?.text = song.duration
		
	}
	
	weak var delegate: AlbumDetailTableViewCellDelegate?
	@IBOutlet var songNameTextField: UITextField!
	@IBOutlet var songDurationTextField: UITextField!
	@IBOutlet var addSongButtonOutlet: UIButton!
	
	var song: Song? {
		didSet { setupViews() }
	}
	
}
