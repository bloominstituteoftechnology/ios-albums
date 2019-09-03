//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Marlon Raskin on 9/3/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {


	@IBOutlet weak var songTitleTextField: UITextField!
	@IBOutlet weak var durationTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBAction func addSongTapped(_ sender: UIButton) {
		
	}

}
