//
//  SongTableViewCell.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/11/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    // IB Outlets
    @IBOutlet weak var songTitleTxtField: UITextField!
    @IBOutlet weak var songDurationTxtField: UITextField!
    @IBOutlet weak var addSongBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //IB actions
    
    @IBAction func addSongBtnWasPressed(_ sender: Any) {
    }
    
    
    
}
