//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Wyatt Harrell on 4/6/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var delegate: SongTableViewCellDelegate?
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let song = song {
            songTitleTextField.text = song.name
            durationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleTextField.text, !title.isEmpty, let duration = durationTextField.text, !duration.isEmpty else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    override func prepareForReuse() {
        addSongButton.isHidden = false
        songTitleTextField.text = ""
        durationTextField.text = ""
    }
}

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}
