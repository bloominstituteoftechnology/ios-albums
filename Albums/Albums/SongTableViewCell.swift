//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    
    weak var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews() {
        guard let song = song else {
            
            addSongButton.isHidden = false
            return
        }
        
        songTitleTextField.text = song.name
        durationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }

    @IBAction func addSongButtonPressed(_ sender: UIButton) {
        guard let title = songTitleTextField.text, !title.isEmpty, let duration = durationTextField.text, !duration.isEmpty else {return}
        delegate?.addSong(with: title, duration: duration)
        print("pressed!")
    }
    
}
