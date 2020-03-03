//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Moses Robinson on 2/18/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBAction func addSong(_ sender: Any) {
        guard let title = songTitle.text, !title.isEmpty,
            let duration = durationTextField.text, !duration.isEmpty else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    private func updateViews() {
        guard let song = song else { return }
        
        songTitle.text = song.name
        durationTextField.text = song.duration
        addButton.isHidden = true
    }
    
    override func prepareForReuse() {
        
        songTitle.text = ""
        durationTextField.text = ""
        addButton.isHidden = false
    }
    
    // MARK: - Properties
   
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?
    
    @IBOutlet var songTitle: UITextField!
    @IBOutlet var durationTextField: UITextField!
    @IBOutlet var addButton: UIButton!
}
