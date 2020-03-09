//
//  SongTableViewCell.swift
//  Albums Sprint Challenge
//
//  Created by Elizabeth Wingate on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTextField: UITextField!

       @IBOutlet weak var durationTextField: UITextField!

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
