//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    var song: Song?
    
    weak var delegate: SongTableViewCellDelegate?

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        titleField.text = ""
        durationField.text = ""
        addSongButton.isHidden = false
    }
    
    func updateViews() {
        guard let song = song else { return }
        titleField.text = song.name
        durationField.text = song.duration
        addSongButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let title = titleField.text, !title.isEmpty,
            let duration = durationField.text, !duration.isEmpty
            else { return }
        delegate?.addSong(withName: title, duration: duration)
    }
}

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(withName name: String, duration: String)
}
