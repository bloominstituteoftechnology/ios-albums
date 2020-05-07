//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Marissa Gonzales on 5/7/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var songTitleTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
