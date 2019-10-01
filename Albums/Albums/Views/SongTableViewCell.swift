//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
       
    @IBAction func addSongButton(_ sender: UIButton) {
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
