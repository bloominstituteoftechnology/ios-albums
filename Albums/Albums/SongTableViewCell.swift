//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func addSongTapped(_ sender: UIButton) {
    }
}
