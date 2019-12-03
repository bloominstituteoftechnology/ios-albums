//
//  SongTableViewCell.swift
//  Albums
//
//  Created by morse on 12/2/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - Properties
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SongTableViewCellDelegate?
    
    // MARK: - Lifecycle Methods
    
    // MARK: - Actions
    
    @IBAction func addTapped(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = durationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    // MARK: - Private
    
    func updateViews() {
        if let song = song {
            addSongButton.isHidden = true
            
            songTitleTextField.text = song.name
            durationTextField.text = song.duration
        }
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
    }
}

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}
