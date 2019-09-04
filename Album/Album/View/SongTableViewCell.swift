//
//  SongTableViewCell.swift
//  Album
//
//  Created by Bradley Yin on 9/2/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var durationLabel: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var song: Song? {
        didSet{
            updateViews()
        }
    }
    var delegate: SongTableViewCellDelegate?
    
    func updateViews() {
        guard let song = song else { return }
        titleLabel.text = song.title
        durationLabel.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        durationLabel.text = nil
        addSongButton.isHidden = false
    }
    @IBAction func addSongTapped(_ sender: Any) {
        guard let title = titleLabel.text, !title.isEmpty, let duration = durationLabel.text, !duration.isEmpty else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
}
