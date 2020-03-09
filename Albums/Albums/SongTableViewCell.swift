//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Zack Larsen on 2/10/20.
//  Copyright © 2020 Zack Larsen. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var SongTitleText: UIStackView!
    @IBOutlet weak var SongDurationText: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func AddSongButton(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
