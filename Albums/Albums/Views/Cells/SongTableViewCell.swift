//
//  SongTableViewCell.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
}
