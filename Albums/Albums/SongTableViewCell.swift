//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Alex Thompson on 1/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard let title = songTitle.text,
            let duration = duration.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    weak var delegate: SongTableViewCellDelegate?

    func updateViews() {
        if let song = song {
            addButton.isHidden = true
            
            songTitle.text = song.title
            duration.text = song.duration
        }
    }
    
    override func prepareForReuse() {
        songTitle.text = ""
        duration.text = ""
        addButton.isHidden = false
    }
}

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}
