//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/11/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addSongButtonPressed(_ sender: UIButton) {
    }
}
