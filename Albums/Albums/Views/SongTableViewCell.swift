//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Vici Shaweddy on 10/30/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addPressed(_ sender: Any) {
    }
}
