//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Nonye on 5/7/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var songTitleText: UITextField!
    
    @IBOutlet weak var songDurationText: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addSongTapped(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
