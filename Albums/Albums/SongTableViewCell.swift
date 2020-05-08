//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Marissa Gonzales on 5/7/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    

    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var songTitleTextField: UITextField!
    
    var song: Album.Song? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SongTableViewCellDelegate?
    
    
    func updateViews() {
        guard let song = song else {
            addSongButton.isHidden = false
            return
        }
        songTitleTextField.text = song.title
        durationTextField.text = song.duration
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSongTapped(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = durationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
        
    }
}
