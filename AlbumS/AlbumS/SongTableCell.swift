//
//  SongTableCell.swift
//  AlbumS
//
//  Created by Nick Nguyen on 3/9/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

protocol SongTableCellDelegate: AnyObject {
    func didAddSong(with title: String,duration:String)
}

class SongTableCell: UITableViewCell {

    var song: Song? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SongTableCellDelegate?

    func updateViews() {
        if let song = song {
            songTitleTextField.text = song.name
            songDurationTextField.text = song.duration
            
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        addSongButton.isHidden = false
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        
    }
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    
   
    
    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let title = songTitleTextField.text,
            let duration = songDurationTextField.text else { return }
        delegate?.didAddSong(with: title, duration: duration)
    }
    
    
    @IBOutlet weak var addSongButton: UIButton!
    
}
