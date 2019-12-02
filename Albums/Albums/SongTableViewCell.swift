//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    }
}
