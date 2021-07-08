//
//  SongTableViewCell.swift
//  ios-Albums
//
//  Created by Jerrick Warren on 11/26/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBAction func addSongButton(_ sender: Any) {
    }
    
    
    
    
}
