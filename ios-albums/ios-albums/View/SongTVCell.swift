//
//  SongTVCell.swift
//  ios-albums
//
//  Created by Nikita Thomas on 11/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class SongTVCell: UITableViewCell {
    @IBOutlet weak var songTitleOutlet: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var durationOutlet: UITextField!
    
    
    @IBAction func addSong(_ sender: Any) {
        
        
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
