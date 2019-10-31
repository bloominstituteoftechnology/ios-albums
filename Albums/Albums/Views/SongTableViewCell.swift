//
//  SongTableViewCell.swift
//  Albums
//
//  Created by John Kouris on 10/30/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!

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
    

}
