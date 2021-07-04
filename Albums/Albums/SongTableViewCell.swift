//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBAction func addSongButtonPressed(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = durationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateView() {
        guard let song = song else {
            addSongButton.isHidden = false
            return
        }

        songTitleTextField.text = song.name
        durationTextField.text = song.duration
        addSongButton.isHidden = true
    }

    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }

    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
}
