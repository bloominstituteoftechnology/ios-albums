//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Kenneth Jones on 5/15/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addTapped(_ sender: Any) {
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
