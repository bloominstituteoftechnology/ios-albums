//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Morgan Smith on 5/14/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitle: UITextField!
    
    @IBOutlet weak var songDuration: UITextField!
    
    @IBOutlet weak var addSong: UIButton!
    
    @IBAction func addSong(_ sender: UIButton) {
    }
    
}
