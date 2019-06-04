//
//  SongTableViewCell.swift
//  An Album Cover
//
//  Created by Michael Redig on 6/3/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

	@IBOutlet var songNameField: UITextField!
	@IBOutlet var songDurationField: UITextField!
	@IBOutlet var saveButton: UIButton!

	weak var delegate: SongTableViewCellDelegate?
	var song: Song? {
		didSet {
			updateViews()
		}
	}

	private func updateViews() {
		guard let song = song else { return }
		saveButton.isHidden = true
		songNameField.text = song.name
		songDurationField.text = song.duration
	}

	override func prepareForReuse() {
		saveButton.isHidden = false
		songNameField.text = ""
		songDurationField.text = ""
	}

	@IBAction func durationFieldChanged(_ sender: UITextField) {
		let legalCharacters = Set("0123456789.:")
		sender.text = sender.text?.filter { legalCharacters.contains($0) }
	}

	@IBAction func saveButtonPressed(_ sender: UIButton) {
		guard let title = songNameField.text, !title.isEmpty,
			let duration = songDurationField.text, !duration.isEmpty else { return }
		delegate?.addSong(with: title, duration: duration)
	}
}


protocol SongTableViewCellDelegate: AnyObject {
	func addSong(with title: String, duration: String)
}
