//
//  SongTableViewCell.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func addSong(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
