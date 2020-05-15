//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by Rob Vance on 5/14/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Mark: IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    
    
    // Mark: IBActions
    @IBAction func addSongTapped(_ sender: Any) {
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
