//
//  SongTableViewCell.swift
//  iOS-Album
//
//  Created by Cameron Collins on 4/9/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Actions
    @IBAction func AddSongPressed(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
