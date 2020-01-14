//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Chad Rutherford on 1/13/20.
//  Copyright © 2020 chadarutherford.com. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Configuration
    private func updateViews() {
        guard let song = song else { return }
        titleTextField.text = song.name
        durationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        titleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
            let duration = durationTextField.text, !duration.isEmpty else { return }
        delegate?.addSong(with: title, duration: duration)
    }
}
