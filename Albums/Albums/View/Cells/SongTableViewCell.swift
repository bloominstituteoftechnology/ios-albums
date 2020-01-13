//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Chad Rutherford on 1/13/20.
//  Copyright © 2020 chadarutherford.com. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func addSongTapped(_ sender: UIButton) {
        
    }
}
