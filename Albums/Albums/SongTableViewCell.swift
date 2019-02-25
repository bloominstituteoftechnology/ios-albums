//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
}
