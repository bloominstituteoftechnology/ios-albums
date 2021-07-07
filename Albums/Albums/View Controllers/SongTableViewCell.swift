//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    func updateViews() {
        if let song = song {
            songTitleTextField.text = song.title
            songDurationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    
    
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleTextField.text, !title.isEmpty,
            let duration = songDurationTextField.text, !duration.isEmpty else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var songDurationTextField: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    
    var song: Song?

    var delegate: SongTableViewCellDelegate?

}

