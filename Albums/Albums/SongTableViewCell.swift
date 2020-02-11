//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Michael on 2/10/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    var song: Song?
    
    weak var delegate: SongTableViewCellDelegate?
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    

    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard
            let songTitle = songTitleTextField.text,
            let duration = songDurationTextField.text,
            !songTitle.isEmpty,
            !duration.isEmpty
            else { return }
        delegate?.addSong(with: songTitle, duration: duration)
    }
    
    func updateViews() {
        if let song = song {
            songTitleTextField.text = song.name
            songDurationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        songTitleTextField.clearsOnBeginEditing = true
        songDurationTextField.clearsOnBeginEditing = true
        addSongButton.isHidden = false 
    }
}
