//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Enrique Gongora on 3/9/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let title = songDurationTextField.text, let duration = songDurationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    // MARK: - Functions
    func updateViews() {
        if let song = song {
            songTextField.text = song.title
            songDurationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        addSongButton.isHidden = false
        songTextField.text = ""
        songDurationTextField.text = ""
    }
    
}
