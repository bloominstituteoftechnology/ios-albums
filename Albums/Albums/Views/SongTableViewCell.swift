//
//  SongTableViewCell.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addsong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        if let song = song {
            songTitleTextField.text = song.name
            songDurationTextField.text = song.duration
            addSongButton.isHidden = true
        } else {
            addSongButton.isHidden = false
        }
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = songDurationTextField.text,
            !title.isEmpty,
            !duration.isEmpty else { return }
        delegate?.addsong(with: title, duration: duration)
    }
    

}
