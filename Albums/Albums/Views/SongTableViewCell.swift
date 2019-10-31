//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Bobby Keffury on 10/30/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import UIKit

class SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {}
}


class SongTableViewCell: UITableViewCell {
    
    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addSongTapped(_ sender: Any) {
        guard let duration = durationTextField.text, !duration.isEmpty, let name = songTitleTextField.text, !name.isEmpty else { return }
        delegate?.addSong(with: name, duration: duration)
        updateViews()
    }
    
    
    func updateViews() {
        guard let song = song else { return }
        durationTextField.text = song.duration
        songTitleTextField.text = song.name
        addSongButton.isHidden = true
    }
    
    
    override func prepareForReuse() {
        durationTextField.text = nil
        songTitleTextField.text = nil
        addSongButton.isHidden = false
    }
    
}
