//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Lambda_School_Loaner_204 on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?
    
    private func updateViews() {
        if let song = song {
            songTitleTextField.text = song.name
            songDurationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addSongTapped(sender: UIButton) {
        guard let songString = songTitleTextField.text,
            !songString.isEmpty,
            let durationString = songDurationTextField.text,
            !durationString.isEmpty else { return }
        
        delegate?.addSong(with: songString, duration: durationString)
    }
}
