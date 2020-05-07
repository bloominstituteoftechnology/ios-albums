//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Dahna on 5/7/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: Actions
    
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
