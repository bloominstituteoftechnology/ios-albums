//
//  SongTableViewCell.swift
//  Albums
//
//  Created by David Williams on 5/14/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    var song: Song?
    var delegate: SongTableViewCellDelegate?

    @IBOutlet weak var albumTitleTextField: UITextField!
    @IBOutlet weak var albumDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    func updateViews() {
        guard let song = song else { return }
        albumTitleTextField.text = song.name
        albumDurationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        albumTitleTextField.text = ""
        albumDurationTextField.text = ""
        addSongButton.isHidden = false
    }

    @IBAction func addSongTapped(_ sender: Any) {
        guard let albumTitle = albumTitleTextField.text,
            let albumDuration = albumDurationTextField.text else { return }
        
        delegate?.addSong(with: albumTitle, duration: albumDuration)
    }
}
