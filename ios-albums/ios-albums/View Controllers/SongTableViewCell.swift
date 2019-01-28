//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by TuneUp Shop  on 1/28/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    
    //MARK: - Interface Builder
    
    //Outlets
    @IBOutlet weak var songCellTitleTextField: UITextField!
    
    @IBOutlet weak var songCellDurationTextField: UITextField!
    
    @IBOutlet weak var saveNewSongButton: UIButton!
    
    
    //Actions
    
    
    @IBAction func saveNewSong(_ sender: UIButton) {
    }
    
}
