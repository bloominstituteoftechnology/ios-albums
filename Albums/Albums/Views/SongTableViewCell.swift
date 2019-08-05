//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Kat Milton on 8/5/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet var songTitleTextField: UITextField!
    @IBOutlet var songDurationTextField: UITextField!
    @IBOutlet var addSongButton: UIButton!

    weak var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let song = song else {
            addSongButton.isHidden = false
            return
        }
        songTitleTextField.text = song.name
        songDurationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSongButtonPressed(_ sender: UIButton) {
        guard let title = songTitleTextField.text, !title.isEmpty,
            let duration = songDurationTextField.text, !duration.isEmpty else {return}
        delegate?.addSong(with: title, duration: duration)
    }

}
