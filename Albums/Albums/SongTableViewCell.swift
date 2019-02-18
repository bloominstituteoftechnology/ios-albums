//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
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
    @IBAction func addSongTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    
    

}
