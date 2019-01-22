//
//  AlbumsDetailTableViewCell.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class AlbumsDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    
}
