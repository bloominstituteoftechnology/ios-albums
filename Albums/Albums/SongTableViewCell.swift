//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBAction func addSongButtonPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
}
