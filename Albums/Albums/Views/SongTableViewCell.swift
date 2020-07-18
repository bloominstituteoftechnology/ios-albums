//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Cora Jacobson on 7/16/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    weak var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!

    @IBAction func addSongButton(_ sender: UIButton) {
        if let title = songTitleTextField.text,
            !title.isEmpty,
            let duration = durationTextField.text,
            !duration.isEmpty {
            delegate?.addSong(with: title, duration: duration)
        }
    }
    
    func updateViews() {
        if let song = song {
            songTitleTextField.text = song.title
            durationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
}

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}
