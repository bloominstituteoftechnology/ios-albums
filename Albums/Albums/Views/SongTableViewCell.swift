//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var songNameField: UITextField!
    @IBOutlet weak var songDurationField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions

    @IBAction func addSongButtonTapped(_ sender: Any) {
    }
}
