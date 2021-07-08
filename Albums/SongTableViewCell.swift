//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Yvette Zhukovsky on 11/19/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    @IBOutlet weak var addSong: UIButton!
    
    @IBOutlet weak var songTitle: UITextField!
    
    @IBOutlet weak var durationSong: UITextField!
    
    
    @IBAction func addingSong(_ sender: Any) {
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
