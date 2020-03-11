//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {


    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    @IBAction func addSongButtonTapped(_ sender: Any) {
    }
}
