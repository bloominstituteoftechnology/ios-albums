//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Thomas Cacciatore on 6/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

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
    
    
    
    
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var songDurationTextField: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    
    

}
