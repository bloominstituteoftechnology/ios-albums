//
//  SongTableViewCell.swift
//  Albums
//
//  Created by admin on 10/28/19.
//  Copyright © 2019 admin. All rights reserved.
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
    
    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
