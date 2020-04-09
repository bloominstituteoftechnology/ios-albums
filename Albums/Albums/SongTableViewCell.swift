//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Harmony Radley on 4/9/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
    }
    
    
    

}
