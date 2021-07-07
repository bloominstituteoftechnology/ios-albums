//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Alex Shillingford on 10/28/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets/Properties
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - IBActions
    @IBAction func addSong(_ sender: UIButton) {
        
    }
}
