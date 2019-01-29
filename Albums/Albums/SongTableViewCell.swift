//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Ivan Caldwell on 1/28/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBAction func addSongButtonTapped(_ sender: Any) {
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
