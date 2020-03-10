//
//  SongTableViewCell.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?
    
    @IBAction func addButtonTapped(_ sender: Any) {
        delegate?.addSong(with: titleTextField.text ?? "", duration: durationTextField.text ?? "")
    }
    
    func updateViews() {
        if let song = song {
            titleTextField.text = song.title
            durationTextField.text = song.duration
            addButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        titleTextField.text = ""
        durationTextField.text = ""
        addButton.isHidden = false
    }
}

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}
