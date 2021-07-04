//
//  SongCell.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

protocol SongCellDelegate {
	func newSongAdded(_ newSong: Song)
}

class SongCell: UITableViewCell {

	//MARK: - IBOutlets
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var durationTextField: UITextField!
	@IBOutlet weak var addSongBtn: UIButton!
	
	//MARK: - Properties
	
	var delegate: SongCellDelegate?
	var song: Song? {
		didSet {
			configCell()
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func addSongBtnTapped(_ sender: Any) {
		guard let title = titleTextField.optionalText, let duration = durationTextField.optionalText else { return }
		let newSong = Song(id: nil, title: title, duration: duration)
		
		delegate?.newSongAdded(newSong)
	}
	
	//MARK: - Helpers
	
	private func configCell() {
		guard let song = song else { return }
		titleTextField.text = song.title
		durationTextField.text = song.duration
		
		titleTextField.isEnabled = false
		durationTextField.isEnabled = false
		addSongBtn.isHidden = true
	}
	
}
