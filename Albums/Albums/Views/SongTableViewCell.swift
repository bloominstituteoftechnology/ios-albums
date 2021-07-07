//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Paul Yi on 2/25/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

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
    
    func updateViews() {
        guard let song = song else { return }
        
        songTitleTextField.text = song.songName
        songDurationTextField.text = song.duration
        addSongButton.isHidden = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSong(_ sender: Any) {
        guard let songName = songTitleTextField.text,
            let duration = songDurationTextField.text else { return }
        
        delegate?.addSong(with: songName, duration: duration)
    }
    

}
