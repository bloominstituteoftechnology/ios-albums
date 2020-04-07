//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    // MARK: - Properites
    var song: Song?
    
    // MARK: - Outlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButtonOutlet: UIButton!
    
    // MARK: - Actions
    
    @IBAction func addSongButton(_ sender: Any) {
    }
    
    private func updateViews() {
        if let song = song {
            titleTextField.text = song.title
            durationTextField.text = song.duration
        } else {
            addSongButtonOutlet.isHidden = true
        }
    }

    override func prepareForReuse() {
        titleTextField.text = ""
        durationTextField.text = ""
        addSongButtonOutlet.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
