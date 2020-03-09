//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Enrique Gongora on 3/9/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func addSongTapped(_ sender: UIButton) {
        
    }
    
}
