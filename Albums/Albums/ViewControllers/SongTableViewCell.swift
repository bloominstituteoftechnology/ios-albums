//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Hayden Hastings on 6/10/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
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

    // MARK: - IBActions
    @IBAction func AddSongButtonPressed(_ sender: Any) {
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var DurationTextField: UITextField!
    @IBOutlet weak var AddSongButton: UIButton!
}
