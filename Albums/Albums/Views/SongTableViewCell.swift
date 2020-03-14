//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addSongButtonPressed(_ sender: UIButton) {
        guard let songTitle = songTitleTextField.text,
            let duration = songDurationTextField.text,
            !songTitle.isEmpty,
            !duration.isEmpty else { return }
        delegate?.addSong(with: songTitle, duration: duration)
    }
    
    func updateViews() {
        if let song = song {
            songTitleTextField.text = song.name
            songDurationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        <#code#>
    }
}
