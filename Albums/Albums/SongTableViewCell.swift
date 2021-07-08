//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Percy Ngan on 9/30/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

	@IBOutlet weak var songTitleTextField: UITextField!
	@IBOutlet weak var durationTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	// MARK: - Actions
	@IBAction func addSongButton(_ sender: Any) {
	}
}
