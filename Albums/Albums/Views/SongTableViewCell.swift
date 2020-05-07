//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Kelson Hartle on 5/6/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    
    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        
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
