//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Lisa Sampson on 8/31/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songName = songLabel.text,
            let duration = durationLabel.text else { return }
        
        delegate?.addSong(with: songName, duration: duration)
    }
    
    func updateViews() {
        guard let song = song else { return }
        
        songLabel.text = song.songName
        durationLabel.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        songLabel.text = ""
        durationLabel.text = ""
        addSongButton.isHidden = false
    }
    
    weak var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var songLabel: UITextField!
    @IBOutlet weak var durationLabel: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
}
