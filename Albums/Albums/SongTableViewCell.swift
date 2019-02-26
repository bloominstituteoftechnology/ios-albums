//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        guard let title = songTitleTextField.text,
            let duration = songDurationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    func updateViews() {
        guard let song = song else { return }
        songTitleTextField.text = song.name
        songDurationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
}
