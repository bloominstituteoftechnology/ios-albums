//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Chris Gonzales on 3/9/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album?
    var song: Song?
    
    var delegate: SongTableViewCellDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let songText = songTitleTextField.text,
            !songText.isEmpty,
            let durationText = durationTextField.text,
            !durationText.isEmpty else { return }
        delegate?.addSong(with: songText,
                          duration: durationText)
    }
    
    // MARK: - Methods
    
    func updateViews() {
        guard let song = song else { return }
        songTitleTextField.text = song.name
        durationTextField.text = song.duration
        saveButton.isHidden = true
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
        saveButton.isHidden = false
    }
}

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}
