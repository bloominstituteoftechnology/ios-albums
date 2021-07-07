//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jonalynn Masters on 10/28/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Actions
    @IBAction func addSongButtonClicked(_ sender: Any) {
    }
    
}
