//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Kobe McKee on 6/10/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
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
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    @IBAction func addSong(_ sender: UIButton) {
        guard let title = songTitleTextField.text,
            !songTitleTextField.text!.isEmpty,
            let duration = songDurationTextField.text,
            !songDurationTextField.text!.isEmpty else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    
    func updateViews() {
        guard let song = song else { return }
        songTitleTextField.text = song.name
        songDurationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }


}

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}
