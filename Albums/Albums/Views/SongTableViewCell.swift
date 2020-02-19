//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Sean Acres on 8/5/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SongTableViewCellDelegate?
    
    override func prepareForReuse() {
        titleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSongTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            let duration = durationTextField.text,
            !duration.isEmpty else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    private func updateViews() {
        if let song = song {
            titleTextField.text = song.name
            durationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
}
