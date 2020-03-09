//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Ufuk Türközü on 09.03.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addSong(_ sender: Any) {
    }
    
}
